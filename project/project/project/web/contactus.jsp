<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- Google Fonts -->
    <link
      href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700;800;900&family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap"
      rel="stylesheet"
    />

    <!-- Icon -->
    <link
      rel="stylesheet"
      href="https://unicons.iconscout.com/release/v4.0.0/css/line.css"
    />
    <!-- icon -->

    <!-- Google fonts End -->

    <!-- custon style Sheet & JavaScript -->
    <link rel="stylesheet" href="css/shoppage/index.css" />
    <link rel="stylesheet" href="css/shoppage/shop.css" />
    <link rel="stylesheet" href="css/shoppage/blog.css" />
    <link rel="stylesheet" href="css/shoppage/contactus.css" />
    <script src="js/shoppage/index.js" defer></script>
    <!-- custon style Sheet & JavaScript -->
    <title>Ecommerce Website</title>
  </head>
  <body class="home">
    <header class="primary-header container flex">
                <div class="header-inner-one flex">
                    <div class="logo">
                        <img src="img/logo.png" alt="" />
                    </div>
                    <button
                        class="mobile-close-btn"
                        data-visible="false"
                        aria-controls="primary-navigation"
                        >
                        <i class="uil uil-times-circle"></i>
                    </button>
                    <nav>
                        <ul
                            id="primary-navigation"
                            data-visible="false"
                            class="primary-navigation flex"
                            >
                            <li>
                                <a class="active fs-100 fs-montserrat bold-500" href="home"
                                   >Home</a
                                >
                            </li>
                            <li>
                                <a class="fs-100 fs-montserrat bold-500" href="shop"
                                   >Shop</a
                                >
                            </li>
                            <li>
                                <a class="fs-100 fs-montserrat bold-500" href="customerblog"
                                   >Blog</a
                                >
                            </li>
                            <li>
                                <a class="fs-100 fs-montserrat bold-500" href="about.jsp"
                                   >About Us</a
                                >
                            </li>

                            <li>
                                <a class="fs-100 fs-montserrat bold-500" href="contactus.jsp"
                                   >Contact Us</a
                                >
                            </li>

                        </ul>
                    </nav>
                </div>

                <div class="header-login flex">
                    <c:if test="${sessionScope.acc.full_name == null}">
                        <a style="text-decoration: none;
                           color: black"class="fs-100 fs-montserrat bold-500" href="login.jsp">Login</a></p>
                        </c:if>
                        <c:if test="${sessionScope.acc.full_name != null}">
                            <p style="text-decoration: none;
                            color: black"class="fs-100 fs-montserrat bold-500" id="acc-box" aria-controls="acc-icon">${sessionScope.acc.getFull_name()}</p>

                        </c:if>
                        <a  href="showCart">
                            <i class="uil uil-shopping-bag"
                               ></i>${n}
                        </a>
                        <!-- =================1111111111================== -->
                        <div id="cart-icon" data-visible="false" class="cart-icon">
                            <div class="shopping flex">
                                <p>Shopping Basket</p>
                                <i id="cross-btn" class="uil uil-times"></i>
                            </div>
                            <div class="cart bold-800 flex">
                                <i class="uil uil-shopping-cart-alt"></i>
                                <p>Cart Is Empty</p>

                                <!-- ================================================== -->

                                <!-- ================================================== -->
                            </div>
                        </div>
                        <div id="acc-icon" data-visible="false" class="cart-icon">
                            <div class="shopping flex">
                                <p>Shopping Basket</p>
                                <i id="cross-btn" class="uil uil-times"></i>
                            </div>
                            <div style="padding-top: 2rem;" class="cart bold-800 flex">
                            <a style="text-decoration: none;
                               color: black"class="fs-100 fs-montserrat bold-500" href="logout">Log out</a>
                            </div>
                            <div style="padding-top: 2rem;" class="cart bold-800 flex">
                            <a style="text-decoration: none;
                               color: black"class="fs-100 fs-montserrat bold-500" href="accsettings">Account Settings</a>
                            </div>
                            <div style="padding-top: 2rem;" class="cart bold-800 flex">
                            <a style="text-decoration: none;
                               color: black"class="fs-100 fs-montserrat bold-500" href="changePassword">Change Passwords</a>
                            </div>
                            <div style="padding-top: 2rem;" class="cart bold-800 flex">
                            <form action="orderhistory" method="post">
                                <input type="hidden" value="${sessionScope.acc.id}" name="accid"/>
                                <input style="border: none;" class="fs-100 fs-montserrat bold-500" type="submit" value="View Order History"/>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="mobile-open-btn"><i class="uil uil-align-right"></i></div>
            </header>
    <!-- ===================Shop Feature Section============================ -->

    <section class="shop-feature bg-gray grid">
      <div>
        <p class="fs-montserrat text-black">
          Home <span aria-hidden="true" class="margin">></span> Contact Us
        </p>
      </div>
      <h2 class="fs-poppins fs-300 bold-700">Contact Us</h2>
    </section>

    <!-- ===================Contact Us======================== -->

    <section class="contact-us grid">
      <div class="contact-info">
        <div>
          <h1 class="fs-poppins text-red fs-200">Contact Us</h1>
          <h3 class="fs-poppins text-black fs-400">Get In ouch</h3>
          <p class="fs-montserrat fs-100">
            When, while lovely valley teems with vapour around meand meridian
            the upper impenetrable .
          </p>
        </div>
        <form action="#" class="contact-form grid">
          <div class="grid">
            <input
              class="bg-gray text-black fs-poppins"
              type="text"
              placeholder="Your E-mail"
            />
          </div>
          <div class="grid">
            <input
              class="bg-gray text-black fs-poppins"
              type="text"
              placeholder="Phone number"
            />
          </div>
          <div>
            <textarea
              class="bg-gray text-black fs-poppins"
              rows="10"
              placeholder="Your Message Here"
            >
            </textarea>
          </div>

          <div class="contact-btn">
            <button class="large-btn bg-red text-white fs-poppins fs-50">
              Submit
            </button>
          </div>
        </form>
      </div>

      <!-- ================map===================== -->
      <div>
        <div class="map">
          <h4 class="fs-poppins fs-200 text-red">
            Address
          </h4>
          
                  <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.506216903998!2d105.5227142743384!3d21.012421688341366!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135abc60e7d3f19%3A0x2be9d7d0b5abcbf4!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBGUFQgSMOgIE7hu5lp!5e0!3m2!1svi!2s!4v1718080192188!5m2!1svi!2s" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>

        </div>
      </div>
    </section>

    <!-- ===========Support Section==================== -->

    <section class="suport-container grid">
      <div class="support-info grid">
        <div class="suport-img grid">
          <img src="image/sup-1.svg" alt="" />
        </div>
        <div>
          <p class="fs-100">
            <span class="fs-200 fs-poppins bold-700">Email:</span
            > info@yourdomain.com
          </p>
          <p class="fs-poppins fs-100">info@samplemail.com</p>
        </div>
      </div>
      <div class="support-info grid">
        <div class="suport-img grid">
          <img src="image/sup-2.svg" alt="" />
        </div>
        <div>
          <p class="fs-100">
            <span class="fs-200 fs-poppins bold-700">Phone:</span
            > +99 (0) 101 0000 888
          </p>
          <p class="fs-poppins fs-100">+99 (0) 101 0000 888</p>
        </div>
      </div>
      <div class="support-info grid">
        <div class="suport-img grid">
          <img src="image/sup-3.svg" alt="" />
        </div>
        <div>
          <p class="fs-100">
            <span class="fs-200 fs-poppins bold-700">Address:</span
            > Patricia C. 4401 Waldeck
          </p>
          <p class="fs-poppins fs-100">Street Grapevine Nashville, Tx 76051</p>
        </div>
      </div>
    </section>

    <!-- ===================Contact Us======================== -->

    <footer>
      <!-- =============Brands================= -->
      <section class="brands grid">
        <div>
          <img src="image/br-1.png" alt="" />
        </div>
        <div>
          <img src="image/br-2.png" alt="" />
        </div>
        <div>
          <img src="image/br-3.png" alt="" />
        </div>
        <div>
          <img src="image/br-4.png" alt="" />
        </div>
        <div>
          <img src="image/br-5.png" alt="" />
        </div>
      </section>

      <!-- =============Footer Menu=================== -->
      <section class="footer grid">
        <div class="footer-logo grid">
          <img src="image/logo.png" alt="" />
          <p class="fs-montserrat fs-200">
            There are many variations passages of Lorem Ipsum available, but the
            majority have
          </p>
          <div class="social-media flex">
            <i class="uil uil-facebook-f"></i>
            <i class="uil uil-instagram"></i>
            <i class="uil uil-linkedin"></i>
            <i class="uil uil-twitter"></i>
          </div>
        </div>

        <div class="footer-menu grid">
          <h3 class="fs-poppins fs-200 bold-800">Quick Links</h3>
          <ul>
            <li>
              <a class="fs-montserrat text-black fs-200" href="#">Home</a>
            </li>
            <li>
              <a class="fs-montserrat text-black fs-200" href="#">About</a>
            </li>
            <li>
              <a class="fs-montserrat text-black fs-200" href="#">Shop</a>
            </li>
            <li>
              <a class="fs-montserrat text-black fs-200" href="#">Contact</a>
            </li>
          </ul>
        </div>

        <div class="contact grid">
          <h3 class="fs-poppins fs-200 bold-800">Contact</h3>
          <p class="fs-montserrat">
            +99 (0) 101 0000 888 Patricia C. Amedee 4401 Waldeck Street
            Grapevine Nashville, Tx 76051
          </p>
        </div>

        <div class="emails grid">
          <h3 class="fs-poppins fs-200 bold-800">Subscribe To Our Email</h3>
          <p class="updates fs-poppins fs-300 bold-800">
            For Latest News & Updates
          </p>
          <div class="inputField flex bg-gray">
            <input
              type="email"
              placeholder="Enter Your Email"
              class="fs-montserrat bg-gray"
            />
            <button class="bg-red text-white fs-poppins fs-50">
              Subscribe
            </button>
          </div>
        </div>
      </section>

      <section class="copyRight">
        <p class="c-font fs-montserrat fs-200">
          Â© 2022 eStore. All rights reserved.
        </p>
        <p class="fs-montserrat fs-100 text-align p-top">
          Privacy Policy . Term Condition
        </p>
      </section>
      <script>
                    const accountBtn = document.getElementById('acc-box');
                    const accItme = document.getElementById('acc-icon');
                    accountBtn.addEventListener('click', () => {
                        const showCart = accItme.getAttribute('data-visible');

                        if (showCart === 'false') {
                            accItme.setAttribute('data-visible', true)
                        } else {
                            accItme.setAttribute('data-visible', false)
                        }
                    })
                </script>
    </footer>
  </body>
</html>
