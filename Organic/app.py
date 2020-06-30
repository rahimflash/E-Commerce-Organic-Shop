from flask import Flask,render_template,url_for,request,redirect,session,g,flash
from flask_mysqldb import MySQL
from werkzeug.utils import secure_filename
from flask import send_from_directory
import MySQLdb.cursors
import yaml
import os
import hashlib
import time
import random

UPLOAD_FOLDER = 'static/images/product'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg'}
app=Flask(__name__)
app.secret_key =os.urandom(24)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
#configuring the mysql db
db=yaml.load(open('db.yaml'))
app.config['MYSQL_HOST']= db['mysql_host']
app.config['MYSQL_USER']= db['mysql_user']
app.config['MYSQL_PASSWORD']= db['mysql_password']
app.config['MYSQL_DB']= db['mysql_db']

mysql=MySQL(app)

@app.route('/')
def home():
    Fname=g.Fname
    one=1
    two=2
    three=3
    four=4
    five=5
    six=6
    yes='YES'
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute("SELECT * FROM product WHERE approved=%s ORDER BY qtysold DESC LIMIT 6",[yes] )
    topProducts=cur.fetchall()
    cur.execute(" SELECT product.*, categoryProduct.* From categoryProduct INNER JOIN product on product.id=categoryProduct.productId INNER JOIN category on category.id=categoryProduct.categoryId Where category.id=%s AND product.approved=%s LIMIT 6",([one],[yes]) )
    bodyScrub=cur.fetchall()
    cur.execute(" SELECT product.*, categoryProduct.* From categoryProduct INNER JOIN product on product.id=categoryProduct.productId INNER JOIN category on category.id=categoryProduct.categoryId Where category.id=%s AND product.approved=%s LIMIT 6",([two],[yes]) )
    bathAndShower=cur.fetchall()
    cur.execute(" SELECT product.*, categoryProduct.* From categoryProduct INNER JOIN product on product.id=categoryProduct.productId INNER JOIN category on category.id=categoryProduct.categoryId Where category.id=%s AND product.approved=%s LIMIT 6",([three],[yes]) )
    diaryAndEggs=cur.fetchall()
    cur.execute(" SELECT product.*, categoryProduct.* From categoryProduct INNER JOIN product on product.id=categoryProduct.productId INNER JOIN category on category.id=categoryProduct.categoryId Where category.id=%s AND product.approved=%s LIMIT 6",([four],[yes]) )
    grain=cur.fetchall()
    cur.execute(" SELECT product.*, categoryProduct.* From categoryProduct INNER JOIN product on product.id=categoryProduct.productId INNER JOIN category on category.id=categoryProduct.categoryId Where category.id=%s AND product.approved=%s LIMIT 6",([five],[yes]) )
    produce=cur.fetchall()
    cur.execute(" SELECT product.*, categoryProduct.* From categoryProduct INNER JOIN product on product.id=categoryProduct.productId INNER JOIN category on category.id=categoryProduct.categoryId Where category.id=%s AND product.approved=%s LIMIT 6",([six],[yes]) )
    proteinProducts=cur.fetchall()                   
       
    cur.close()
    if g.loggedin==None:
        Fname=''
    return render_template('home.html',Fname=Fname,topProducts=topProducts,bodyScrub=bodyScrub,bathAndShower=bathAndShower,diaryAndEggs=diaryAndEggs,grain=grain,produce=produce,proteinProducts=proteinProducts)

@app.route('/search',methods=['GET','POST'])
def search():
    if request.method=='POST':
        test=str(request.form['search'])
        search="%"+test+"%"
        topic="search results for "+test
        cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        if search:
            check=cur.execute("SELECT * FROM product WHERE NAME LIKE %s",([search] ))
            product=cur.fetchall()
            cur.close()
            return render_template('user/layoutSearchResults.html',product=product,topic=topic)  
    

@app.route('/wishlist')
def wishlist():
    if not g.type=='user':
        return redirect('/login')
    
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute("SELECT wishlist.*,product.* FROM wishlist INNER JOIN product on product.id=wishlist.productId  WHERE userId=%s",[g.id])
    product=cur.fetchall()
    return render_template('user/layoutWishlist.html',product=product)

  



#-------------------------------------------------------------------------------

@app.route('/cart')
def cart():
    if not g.type=='user':
        return redirect('/login')
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute("SELECT cart.*,product.* FROM cart INNER JOIN product on product.id=cart.productId  WHERE userId=%s",[g.id])
    cart=cur.fetchall()
    subtotal=0
    total=0
    shippingFee=0
    for item in cart:
        subtotal=subtotal+ (item['price']*item['qty'])
    print (subtotal)
    shippingFee=0.1*subtotal
    total=shippingFee+subtotal
    return render_template('user/layoutCart.html',cart=cart,shippingFee=shippingFee,subtotal=subtotal,total=total)

#-------------------------------------------------------------
@app.route('/checkout',methods=['GET','POST'])
def checkout():
    if not g.type=='user':
        return redirect('/login')
    if request.method=='POST':
        recipientName=request.form['recipientName']
        region=request.form['region']
        city=request.form['city']
        address=request.form['address']
        phoneNumber=request.form['phoneNumber']
        cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)        
        cur.execute("SELECT cart.*,product.* FROM cart INNER JOIN product on product.id=cart.productId  WHERE userId=%s",[g.id])
        cart=cur.fetchall()
        if cart:
            subtotal=0
            total=0
            shippingFee=0
            for item in cart:
                subtotal=subtotal+ (item['price']*item['qty'])
            print (subtotal)
            shippingFee=0.1*subtotal
            total=shippingFee+subtotal
            #generatin a unique tracking number with random, hashlib and the current time
            trackingNumber=hashlib.sha256(str(random.getrandbits(256)+time.time()).encode('utf-8')).hexdigest()[:20]
            orderExists=cur.execute("SELECT * FROM orders where trackingNumber=%s",[trackingNumber])
            if not orderExists:
                paymentMethod='On Delivery'
                cur.execute("INSERT INTO orders(userId,recipientName,trackingNumber,totalAmount,region,city,address,paymentMethod,phoneNumber,shippingFee) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",([g.id],recipientName,[trackingNumber],[total],region,city,address,[paymentMethod],phoneNumber,[shippingFee]))
                orderId=mysql.connection.insert_id()
                status='Processing'
                for item in cart:
                    price=1.1*item['price']
                    cur.execute("INSERT INTO orderContent(userId,productId,orderId,price,qty,status) VALUES(%s,%s,%s,%s,%s,%s)",([g.id],item['id'],[orderId],[price],item['qty'],[status]))
                
                cur.execute("DELETE FROM cart where userId=%s",[g.id])
                mysql.connection.commit()
                cur.close()
                return render_template('user/layoutTrackingNumber.html',trackingNumber=trackingNumber)
        
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute("SELECT cart.*,product.* FROM cart INNER JOIN product on product.id=cart.productId  WHERE userId=%s",[g.id])
    cart=cur.fetchall()
    subtotal=0
    total=0
    shippingFee=0
    for item in cart:
        subtotal=subtotal+ (item['price']*item['qty'])
    print (subtotal)
    shippingFee=0.1*subtotal
    total=shippingFee+subtotal
    return render_template('user/layoutCheckout.html',cart=cart,shippingFee=shippingFee,subtotal=subtotal,total=total)


@app.route('/category/<int:id>')
def category(id):
    yes='YES'
    if id==1:
        topic="Body Scrub"
    elif id==2:
        topic="Bath And Shower"
    elif id==3:
        topic="Diary And Eggs"
    elif id==4:
        topic="Grain"
    elif id==5:
        topic="Produce"
    elif id==6:
        topic="Protein Products"
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute(" SELECT product.*, categoryProduct.* From categoryProduct INNER JOIN product on product.id=categoryProduct.productId INNER JOIN category on category.id=categoryProduct.categoryId Where category.id=%s AND product.approved=%s ",([id],[yes]) )
    product=cur.fetchall()
    if product:
        return render_template('user/layoutSearchResults.html',product=product,topic=topic)





#--------------------------------------------------------------------------------

@app.route('/login',methods=['GET','POST'])
def signIn():
    msg=''
    if request.method=='POST':
        email=request.form['email']
        password=request.form['password']
        cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cur.execute('SELECT * FROM user WHERE email = %s AND password=%s', (email,password))
        account = cur.fetchone()
        cur.close()
        if account:
            session['type']='user'
            session['loggedin'] = True
            session['id'] = account['id']
            session['email'] = account['email']
            session['Fname']=account['Fname']
            user=session['Fname']
            return redirect('/')
        else:
            msg='incorrect email/password'
    return render_template('user/login.html',msg=msg)

@app.route('/product/<int:id>/<string:name>', methods=['GET','POST'])
def product(name,id):
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT p.*,s.nameOfShop FROM product p INNER JOIN shop s ON p.shopId=s.id WHERE p.id=%s ',([id]))
    product=cur.fetchone()
    title="%"+name+"%"
    cur.execute("SELECT * from product where name like %s AND id!=%s LIMIT 3",([title],[id]))
    related=cur.fetchall()
    cur.close()
    print(product)
    if product:
        return render_template ('user/layoutproduct.html',item=product,related=related)
    else:
        return 'page Not Found',404


@app.route('/signup', methods=['GET','POST'])
def signup():
    # Output message if something goes wrong...
    msg=''
    if request.method=='POST':
        Fname=request.form['Fname']
        Lname=request.form['Lname']
        email=request.form['email']
        password=request.form['password']
        phoneNumber=request.form['number']
        cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cur.execute('SELECT * FROM user WHERE email = %s|| phoneNumber=%s', (email,phoneNumber))
        account = cur.fetchone()
        if account:
            msg = 'Account already exists!'
            cur.close()
            return render_template('user/register.html',msg=msg)
        else:
            cur.execute("INSERT INTO user (Fname,Lname,email,password,phoneNumber) VALUES(%s,%s,%s,%s,%s)",(Fname,Lname,email,password,phoneNumber))
            mysql.connection.commit()
            cur.execute('SELECT * FROM user WHERE email = %s AND password=%s', (email,password))
            account = cur.fetchone()
            cur.close()
            if account:
                session['type']='user'
                session['loggedin'] = True
                session['id'] = account['id']
                session['email'] = account['email']
                session['Fname']=account['Fname']
                user=session['Fname']
            return redirect('/')
    return render_template('user/register.html',msg=msg)

@app.route('/logout')
def logout():
    # Remove session data, this will log the user out
   session.pop('loggedin', None)
   session.pop('id', None)
   session.pop('email', None)
   session.pop('type', None)
   session.pop('Fname', None)
   # Redirect to login page
   return redirect(request.referrer)

@app.route('/profile',methods=['GET','POST'])
def userProfile():
    if not g.type=='user':
        return redirect('/login')
    msg=''
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT * FROM user WHERE id = %s', [g.id])
    account = cur.fetchone()
    cur.close()
    print(account)
    Fname=g.Fname
    if request.method=='POST':
        email=request.form['email']
        Fname=request.form['Fname']
        Lname=request.form['Lname']
        phoneNumber=request.form['phoneNumber']
        password=request.form['password']
        newPassword=request.form['newPassword']
        retypeNewPassword=request.form['retypeNewPassword']
        cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cur.execute('SELECT Fname from user where (email=%s OR phoneNumber=%s) AND id!=%s',(email,phoneNumber,[g.id]))
        testEmailPhoneNumber=cur.fetchone()
        if not testEmailPhoneNumber:
            cur.execute('SELECT Fname from user where id=%s AND password=%s',([g.id],password))
            testAccount=cur.fetchone()
            if testAccount:
                if not retypeNewPassword=='':
                    cur.execute('UPDATE user SET email=%s,Fname=%s,Lname=%s,phoneNumber=%s,password=%s WHERE id=%s ',( email,Fname,Lname,phoneNumber,newPassword,[g.id]))           
                else:
                    cur.execute('UPDATE user SET email=%s,Fname=%s,Lname=%s,phoneNumber=%s WHERE id=%s ',( email,Fname,Lname,phoneNumber,[g.id]))
                mysql.connection.commit()    
                cur.close()
                msg='The Changes have Succesfuly been Made'
            else:
                cur.close()
                msg='The Password you entered is wrong'
        else:
            cur.close()
            msg='The email or phone Number you have Entered belongs to another account'         
      
    return render_template('user/layoutprofile.html',account=account,Fname=Fname,msg=msg)

@app.route('/addtowishlist/<int:id>')
def addToWishlist(id):
    if not g.type=='user':
        return redirect('/login')
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT * FROM wishlist WHERE userId=%s AND productId=%s',([g.id],[id]))
    alreadyExists=cur.fetchone()
    if alreadyExists:
        cur.close()
        flash('Item is Already in Wishlist')
        return redirect(request.referrer)
    else:
        cur.execute('INSERT INTO wishlist(userId,productId) VALUES (%s,%s)',([g.id],[id]))
        mysql.connection.commit()
        cur.close()
        flash('Product has been added to your wishlist')
        return redirect(request.referrer)        
    return redirect(request.referrer)

@app.route('/removefromwishlist/<int:id>')
def removeFromwishlist(id):
    if not g.type=='user':
        return redirect('/login')
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT * FROM wishlist WHERE userId=%s AND productId=%s',([g.id],[id]))
    itemExists=cur.fetchone()
    if itemExists:
        cur.execute("DELETE FROM wishlist WHERE userId=%s AND productId=%s",([g.id],[id]))
        mysql.connection.commit()
        return redirect(request.referrer)
    return redirect (request.referrer)


@app.route('/addtocart',methods=['GET','POST'])
def addtocart():
    if not g.type=='user':
        return redirect('/login')
    if request.method=='POST':
        productId=request.form['id']
        qty=request.form['qty']
        cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cur.execute("SELECT * FROM product WHERE id=%s LIMIT 1",[productId])
        product=cur.fetchone()
        cur.close()
        
        if productId and qty and product:
            cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cur.execute('SELECT * FROM cart WHERE userId=%s AND productId=%s',([g.id],[productId]))
            alreadyInCart=cur.fetchone()
            if not alreadyInCart:
                #to check if the product is already in your cart
                cur.execute("INSERT INTO cart(userId,productId,qty) VALUES (%s,%s,%s)",([g.id],[productId],[qty]))
                mysql.connection.commit()
                cur.close()
                flash('Item has been added to cart')
                return redirect('/')
            else:
                cur.execute("SELECT * FROM cart WHERE userId=%s AND productId=%s AND qty=%s",([g.id],[productId],[qty]))
                nochange=cur.fetchone()
                #to see if youre not making an update  to your cart
                if nochange:
                    flash('Item is already in Cart')
                    return redirect(request.referrer)
                else:
                    cur.execute("UPDATE cart SET qty=%s where userId=%s AND productId=%s",([qty],[g.id],[productId]))
                    flash('Cart has been Updated')
                    mysql.connection.commit()
                    return redirect(request.referrer)
            
        return redirect(request.referrer)
    return redirect(request.referrer)


@app.route('/removefromcart/<int:id>')
def removeFromcart(id):
    if not g.type=='user':
        return redirect('/login')
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT * FROM cart WHERE userId=%s AND productId=%s',([g.id],[id]))
    itemExists=cur.fetchone()
    if itemExists:
        cur.execute("DELETE FROM cart WHERE userId=%s AND productId=%s",([g.id],[id]))
        mysql.connection.commit()
        return redirect(request.referrer)
    return redirect (request.referrer)

@app.route('/ordertracking')
@app.route('/orders',methods=['GET','POST'])
def orderTracking():
    if request.method=='POST':
        trackingNumber=request.form['trackingNumber']
        if trackingNumber:
            cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cur.execute('SELECT product.name,product.shopId,product.image1,orders.orderDate,orders.region, orders.city,orderContent.* from orderContent INNER JOIN product ON product.id=orderContent.productId INNER JOIN orders ON  orders.id=ordercontent.orderId WHERE orders.trackingNumber=%s',([trackingNumber]))
            product=cur.fetchall()
            total=0
            for item in product:
                total=total+item['price']
            cur.close()
            return render_template('user/layoutOrders.html',product=product,total=total,trackingNumber=trackingNumber)
    return render_template('user/layoutorderTracking.html')  



#----------------------------------------------------
#-----the real deal....performs this action every time any request is made
@app.before_request
def before_request():
    g.type=None
    g.loggedin= None
    g.id=None
    g.email=None
    g.Fname=None
    if 'loggedin' in session:
        g.type=session['type']
        g.loggedin= session['loggedin']
        g.id=session['id']
        g.email=session['email']
        g.Fname=session['Fname']


def MergeDicts(dict1,dict2):
    if isinstance(dict1,list) and isinstance(dict2,list):
        return dict1 + dict2
    elif isinstance(dict1,dict) and isinstance(dict2,dict):
        return dict(list(dict1.items()) + list(dict2.items()))
    return False

#----------------------------------------------------
#---------------------SELLER PAGE ROUTES--------------
#-----------------------------------------------------
@app.route('/seller/login',methods=['GET','POST'])
def sellerLogin():
    msg=''
    if request.method=='POST':
        email=request.form['email']
        password=request.form['password']
        cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cur.execute('SELECT * FROM shop WHERE email = %s AND password=%s', (email,password))
        account = cur.fetchone()
        cur.close()
        if account:
            session['type']='seller'
            session['loggedin'] = True
            session['id'] = account['id']
            session['email'] = account['email']
            session['Fname']=account['FnameOfOwner']
            return redirect('/seller')
        else:
            msg='incorrect email/password'
    return render_template('seller/login.html',msg=msg)

@app.route('/seller')
def sellerHome():
    if not g.type=='seller':
        return redirect('/seller/login')
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT * FROM shop WHERE id = %s', [g.id])
    account = cur.fetchone()
    print(account)
    processing='Processing'
    cur.execute('SELECT product.name,product.shopId,product.image1,orders.orderDate,orders.region, orders.city,orderContent.* from orderContent INNER JOIN product ON product.id=orderContent.productId INNER JOIN orders ON  orders.id=ordercontent.orderId WHERE product.shopId=%s AND orderContent.status=%s',([g.id],[processing]))
    pendingRequests=cur.fetchall()
    return render_template('seller/index.html',account=account,pendingRequests=pendingRequests)

@app.route('/seller/profile',methods=['GET','POST'])
def sellerProfile():
    if not g.type=='seller':
        return redirect('/seller/login')
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT * FROM shop WHERE id = %s', [g.id])
    account = cur.fetchone()
    cur.close()
    print(account)
    if request.method=='POST':
        email=request.form['email']
        Fname=request.form['Fname']
        Lname=request.form['Lname']
        phoneNumber=request.form['phoneNumber']
        nameOfShop=request.form['nameOfShop']
        region=request.form['region']
        city=request.form['city']
        cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cur.execute('UPDATE shop SET email=%s,FnameOfOwner=%s,LnameOfOwner=%s,phoneNumber=%s,nameOfShop=%s,region=%s,city=%s WHERE id=%s ',( email,Fname,Lname,phoneNumber,nameOfShop,region,city,[g.id]))
        mysql.connection.commit()
        cur.close()
        return redirect(request.referrer)
    return render_template('seller/profile.html',account=account)

@app.route('/seller/products')
def sellerProducts():
    if not g.type=='seller':
        return redirect('/seller/login')
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT * FROM shop WHERE id = %s', [g.id])
    account = cur.fetchone()
    cur.execute('SELECT * FROM product WHERE shopId=%s',[g.id])
    product=cur.fetchall()
    print(product)
    cur.close()
    print(account)
    return render_template('seller/products.html',account=account,product=product)

@app.route('/seller/addproduct',methods=['GET','POST'])
def sellerAddProduct():
    if not g.type=='seller':
        return redirect('/seller/login')
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT * FROM shop WHERE id = %s', [g.id])
    account = cur.fetchone()
    print(account)
    if request.method=='POST':
        image1=request.files['image1']
        image2=request.files['image2']
        image3=request.files['image3']
        nameOfProduct=request.form['productName']
        price=request.form['price']
        qty=int(request.form['qty'])
        weight=float(request.form['weight'])
        dimension=request.form['dimension']
        category=int(request.form['category'])
        description=request.form['description']
        if (image1.filename == '') or (image2.filename=='') or (image3.filename==''):
            flash('No selected file')
            return redirect(request.url)
        if (image1 and allowed_file(image1.filename))or(image2 and allowed_file(image2.filename)) or (image3 and allowed_file(image3.filename)):
            filename1 = secure_filename(image1.filename)
            filename2 = secure_filename(image2.filename)
            filename3 = secure_filename(image3.filename)
            shopId=[g.id]
            cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cur.execute("INSERT INTO product(name,shopId,description,price,qty,weight,dimension,image1,image2,image3) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",(nameOfProduct,shopId,description,price,qty,weight,dimension,image1.filename,image2.filename,image3.filename))
            # to get the auto increment id for the previous insert
            id=mysql.connection.insert_id()
            print(id)
            cur.execute("INSERT INTO categoryproduct(categoryId,productId) VALUES(%s,%s)",(category,id))
            mysql.connection.commit()
            cur.close()
            image1.save(os.path.join(app.config['UPLOAD_FOLDER'], filename1))
            image2.save(os.path.join(app.config['UPLOAD_FOLDER'], filename2))
            image3.save(os.path.join(app.config['UPLOAD_FOLDER'], filename3))
            flash('IMAGE1 HAS BEEN ADDED')
            return redirect('/seller/products')
    return render_template('seller/addproduct.html',account=account)

@app.route('/seller/signup',methods=['GET','POST'])
def sellWithUs():
    # Output message if something goes wrong...
    msg=''
    if request.method=='POST':
        Fname=request.form['Fname']
        Lname=request.form['Lname']
        email=request.form['email']
        password=request.form['password']
        phoneNumber=request.form['phoneNumber']
        nameOfShop=request.form['nameOfShop']
        region=request.form['region']
        city=request.form['city']
        country='Ghana'
        cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cur.execute("SELECT * FROM shop WHERE email = %s", [email])
        emailUsed = cur.fetchone()
        cur.execute('SELECT * FROM shop WHERE phoneNumber=%s', [phoneNumber])
        phoneNumberUsed=cur.fetchone()        
        if emailUsed:
            msg = 'This email has been used for another account!'
            cur.close()            
            return render_template('/seller/register.html',msg=msg)
        elif phoneNumberUsed:
            msg = 'Phone number has been used for another account'
            cur.close()
            return render_template('seller/register.html',msg=msg)
        else:
            cur.execute("INSERT INTO shop (FnameOfOwner,LnameOfOwner,email,password,phoneNumber,nameOfShop,region,city,country) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s)",(Fname,Lname,email,password,phoneNumber,nameOfShop,region,city,country))
            mysql.connection.commit()
            cur.execute('SELECT * FROM shop WHERE email = %s AND password=%s', (email,password))
            account = cur.fetchone()
            cur.close()
            if account:
                session['type']='seller'
                session['loggedin'] = True
                session['id'] = account['id']
                session['email'] = account['email']
                session['Fname']=account['FnameOfOwner']
                return redirect('/seller')
            return redirect('/seller')
    return render_template('seller/register.html',msg=msg)

@app.route('/seller/order/send/<int:id>')
def sendOrder(id):
    if not g.type=='seller':
        return redirect('/seller')
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    status="In Delivery"
    cur.execute('UPDATE orderContent SET status=%s WHERE id=%s',([status],[id]))
    mysql.connection.commit()
    return redirect(request.referrer)
#--------------------------------------------------------

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


#-----------------------------------------------------------------
#---------------------ADMIN PAGE----------------------------------
#-----------------------------------------------------------------
@app.route('/admin/login', methods=['GET','POST'])
def adminLogin():
    msg=''
    if request.method=='POST':
        email=request.form['email']
        password=request.form['password']
        cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cur.execute('SELECT * FROM admin WHERE email = %s AND password=%s', (email,password))
        account = cur.fetchone()
        cur.close()
        if account:
            session['type']='admin'
            session['loggedin'] = True
            session['id'] = account['id']
            session['email'] = account['email']
            session['Fname']=account['Fname']
            return redirect('/admin')
        else:
            msg='incorrect email/password'    
    return render_template('admin/login.html',msg=msg)

@app.route('/admin')
def admin():
    if not g.type=='admin':
        return redirect('/admin/login')
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT * FROM shop')
    shop = cur.fetchall()
    cur.close()
    Fname=g.Fname
    return render_template('admin/index.html',shop=shop,Fname=Fname)

@app.route('/admin/shops/<int:id>')
def shopProduct(id):
    if not g.type=='admin':
        return redirect('/admin/login')
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT shop.nameOfShop,product.* FROM product INNER JOIN shop ON shop.id=product.shopId  WHERE shop.id=%s',[id])
    shop = cur.fetchall()
    cur.execute('SELECT nameOfShop FROM shop where id=%s',[id])
    name=cur.fetchone()
    cur.close()
    Fname=g.Fname    
    return render_template('admin/shopProducts.html',shop=shop,Fname=Fname,name=name)

@app.route('/admin/profile',methods=['GET','POST'])
def adminProfile():
    if not g.type=='admin':
        return redirect('/admin/login')
    msg=''
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT * FROM admin WHERE id = %s', [g.id])
    account = cur.fetchone()
    cur.close()
    print(account)
    Fname=g.Fname
    if request.method=='POST':
        email=request.form['email']
        Fname=request.form['Fname']
        Lname=request.form['Lname']
        phoneNumber=request.form['phoneNumber']
        password=request.form['password']
        newPassword=request.form['newPassword']
        retypeNewPassword=request.form['retypeNewPassword']
        cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cur.execute('SELECT Fname from admin where (email=%s OR phoneNumber=%s) AND id!=%s',(email,phoneNumber,[g.id]))
        testEmailPhoneNumber=cur.fetchone()
        if not testEmailPhoneNumber:
            cur.execute('SELECT Fname from admin where id=%s AND password=%s',([g.id],password))
            testAccount=cur.fetchone()
            if testAccount:
                if not retypeNewPassword=='':
                    cur.execute('UPDATE admin SET email=%s,Fname=%s,Lname=%s,phoneNumber=%s,password=%s WHERE id=%s ',( email,Fname,Lname,phoneNumber,newPassword,[g.id]))           
                else:
                    cur.execute('UPDATE admin SET email=%s,Fname=%s,Lname=%s,phoneNumber=%s WHERE id=%s ',( email,Fname,Lname,phoneNumber,[g.id]))
                mysql.connection.commit()    
                cur.close()
                msg='The Changes have Succesfuly been Made'
            else:
                cur.close()
                msg='The Password you entered is wrong'
        else:
            cur.close()
            msg='The email or phone Number you have Entered belongs to another account'         
      
    return render_template('admin/profile.html',account=account,Fname=Fname,msg=msg)

@app.route('/admin/pendingapproval')
def pendingApproval():
    if not g.type=='admin':
        return redirect('/admin/login')
    Fname=g.Fname
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    no='NO'
    cur.execute('SELECT shop.nameOfShop,shop.phoneNumber,product.* FROM product INNER JOIN shop ON shop.id=product.shopId  WHERE product.approved=%s',[no])
    product = cur.fetchall()
    cur.close()
    return render_template('admin/productApproval.html',Fname=Fname,product=product)

@app.route('/admin/pendingdeliveries')
def pendingDeliveries():
    if not g.type=='admin':
        return redirect('/admin/login')
    Fname=g.Fname
    status="In Delivery"
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT orders.paymentMethod,orders.region,orders.city,orders.address,orders.phoneNumber,orders.recipientName,product.image1,orderContent.* FROM orderContent INNER JOIN orders ON orders.id=orderContent.orderId INNER JOIN product ON product.id=orderContent.productId  WHERE orderContent.status=%s',[status])
    product=cur.fetchall()
    return render_template('admin/pendingDeliveries.html',Fname=Fname,product=product)

@app.route('/admin/deliveredproducts')
def deliveredProducts():
    if not g.type=='admin':
        return redirect('/admin/login')
    Fname=g.Fname
    status='Delivered'
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT orders.paymentMethod,orders.region,orders.city,orders.address,orders.phoneNumber,orders.recipientName,product.image1,orderContent.* FROM orderContent INNER JOIN orders ON orders.id=orderContent.orderId INNER JOIN product ON product.id=orderContent.productId  WHERE orderContent.status=%s',[status])
    product=cur.fetchall()    
    return render_template('admin/deliveredProducts.html',Fname=Fname,product=product)

@app.route('/admin/products')
def allProducts():
    if not g.type=='admin':
        return redirect('/admin/login')
    Fname=g.Fname
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT shop.nameOfShop,product.* FROM product INNER JOIN shop ON shop.id=product.shopId')
    product = cur.fetchall()
    cur.close()    
    return render_template('admin/allProducts.html',Fname=Fname,product=product)

@app.route('/product/approve/<int:id>')
def approveProduct(id):
    if not g.type=='admin':
        return redirect('/admin/login')
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT id FROM product WHERE id=%s',[id])
    checkId=cur.fetchone()
    print(checkId)
    if checkId:
        yes='YES'
        cur.execute('UPDATE product SET approved=%s WHERE id=%s',([yes],[id]))
        mysql.connection.commit()
    cur.close()
    return redirect(request.referrer)

@app.route('/admin/order/delivered/<int:id>')
def deliverProduct(id):
    if not g.type=='admin':
        return redirect('/admin/login')
    cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT id FROM orderContent WHERE id=%s',[id])
    checkId=cur.fetchone()
    print(checkId)
    if checkId:
        status='Delivered'
        cur.execute('UPDATE orderContent SET status=%s WHERE id=%s',([status],[id]))
        mysql.connection.commit()
    cur.close()
    return redirect(request.referrer)

@app.route('/product/delete/<int:id>')
def deleteProduct(id):
    if g.type=='admin':
        cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cur.execute('SELECT * FROM product where id=%s',[id])
        product=cur.fetchone()
        if product:
            inCart=cur.execute("SELECT * FROM cart WHERE productId=%s",[id])
            if inCart:
                cur.execute("DELETE FROM cart WHERE productId=%s",[id])
            inWishlist=cur.execute("SELECT * FROM wishlist WHERE productId=%s",[id])
            if inWishlist:
                cur.execute("DELETE FROM wishlist WHERE productId=%s",[id])
            inCategoryProduct=cur.execute("SELECT * FROM categoryProduct WHERE productId=%s",[id])
            if inCategoryProduct:
                cur.execute("DELETE FROM categoryProduct WHERE productId=%s",[id])
            cur.execute("DELETE FROM product WHERE id=%s",[id])
            mysql.connection.commit()
            cur.close()
            return redirect(request.referrer)
        return redirect(request.referrer)
    if g.type=='seller':
        cur=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cur.execute("SELECT * FROM product where id=%s AND shopId=%s",([id],[g.id]))
        product=cur.fetchone()
        if product:
            inCart=cur.execute("SELECT * FROM cart WHERE productId=%s",[id])
            if inCart:
                cur.execute("DELETE FROM cart WHERE productId=%s",[id])
            inWishlist=cur.execute("SELECT * FROM wishlist WHERE productId=%s",[id])
            if inWishlist:
                cur.execute("DELETE FROM wishlist WHERE productId=%s",[id])
            inCategoryProduct=cur.execute("SELECT * FROM categoryProduct WHERE productId=%s",[id])
            if inCategoryProduct:
                cur.execute("DELETE FROM categoryProduct WHERE productId=%s",[id])
            cur.execute("DELETE FROM product WHERE id=%s",[id])
            mysql.connection.commit()
            cur.close()
            return redirect(request.referrer)
        return redirect(request.referrer)            
        


@app.route("/faqs", methods=['GET', 'POST'])
def faqs():
    return render_template('faqs.html', title='FAQS')   



@app.route("/about", methods=['GET', 'POST'])
def about():
    return render_template('about.html', title='About')   



#------------------------------------------------------------------




if __name__=="__main__":
    app.run(debug=True)