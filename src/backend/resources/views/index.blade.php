<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Me!</title>

        <!-- Bootstrap -->
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Raleway:100,600" rel="stylesheet" type="text/css">

        <!-- Styles -->
        <style>
            .background-image {
                min-height: 100vh;
                position: absolute;
                width: 100vw;
                background-image: url('assets/images/keyboard.jpg');
                background-size: cover;
                //background-size: 100% auto;
                background-repeat: no-repeat;
                background-color: rgba(255,255,255,0.5);
                max-height: 1000px;
                overflow: hidden;
            }

            .background-image::before{
                background-image: url('assets/images/keyboard.jpg');
                filter: blur(5px);
            }

            .full-height{
                min-height: 100vh;
            }

            .full-width{
                width: 100vw;
            }

            .black-overlay{
                background-color: rgba(0,0,0,0.6);
                max-height: 1000px;
                overflow: hidden;
            }

            .flex-center {
                align-items: center;
                display: flex;
                justify-content: center;
            }

            .position-ref {
                position: relative;
            }

            .top-right {
                position: absolute;
                right: 10px;
                
            }

            .content {
                text-align: center;
            }

            .title {
                font-size: 84px;
            }

            .subtitle{
                font-size: 25px;
            }

            .links > a {
                color: #121212;
                padding: 0 25px;
                font-size: 12px;
                font-weight: 600;
                letter-spacing: .1rem;
                text-decoration: none;
                text-transform: uppercase;
            }

            .m-b-md {
                margin-bottom: 30px;
            }

            .navbar-default{
                background-color: rgba(255,255,255,0.7);
                border: 1px solid transparent;
                color: #121212;
                border-radius: 0px !important;
                height: 80px;
                line-height: 80px;
            }

            .navbar-default .navbar-brand{
                color: #121212;
            }

            .navbar-brand{
                line-height: 80px;
                padding: 0px 20px;
                font-size: 22px;
            }

            .white-text{
                color: white;
            }
        </style>
    </head>
    <body>
        <div id="app"></div>
        <!-- <div class="background-image">
            <div class="full-height full-width black-overlay">
                <nav class="navbar navbar-default">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <a href="/" class="navbar-brand">{{ $me[ 'name' ] }} {{ $me[ 'surname' ] }}</a>
                            <div class="top-right links">
                                @if (Route::has('login1'))
                                    <a href="{{ url('/login') }}">Login</a>
                                    <a href="{{ url('/register') }}">Register</a>
                                @endif
                                <a href="">Skills</a>
                                <a href="">Experiences</a>
                                <a href="">Works</a>
                                <a href="">Contacts</a>
                            </div>
                        </div>
                    </div>
                </nav>
                <div class="flex-center position-ref almost-full-height white-text">
                    <div class="content">
                        <div class="title m-b-md">
                            {{ $me[ 'name' ] }} {{ $me[ 'surname' ] }}
                            <br />
                            <span class="subtitle">{{ $quote }}</span>
                        </div>
                        <div id="app"></div>
                    </div>
                </div>
            </div>
        </div> -->
        <script type="text/javascript" src="assets/javascript/main.bundle.js"></script>
        <script type="text/javascript" src="assets/javascript/vendor.bundle.js"></script>
    </body>
</html>
