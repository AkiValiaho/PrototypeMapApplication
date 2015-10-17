<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.3/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js"></script>
    <script type="text/javascript" src="/resources/gmaps.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            function resizeRelevantMode(event, s) {
                if ($(s).val().length > 10 && event.keyCode == 8) {
                    $(s).stop().animate({width: '-=10px'},20);
                    return;
                }
                if ($(s).val().length > 10) {
                    $(s).stop().animate({width: '+=10px'},20);
                }
            };

            $("#nameinput").keydown(function (event) {
                resizeRelevantMode(event, "#nameinput");
            });

            function resizeRelevantModeZeroCheck(event, s) {
                if ($(s).val().length == 0) {
                    $(s).stop().animate({width: '500px'},50);
                }
            };

            $("#nameinput").keyup(function (event) {
                resizeRelevantModeZeroCheck(event, "#nameinput");
            });
            $("#idinputForm").keydown(function (event) {
               resizeRelevantMode(event, "#idinputForm");
            });
            $("#idinputForm").keyup(function (event) {
                resizeRelevantModeZeroCheck(event, "#idinputForm");
            });
            $("#addressInputForm").keydown(function (event) {
                resizeRelevantMode(event, "#addressInputForm");
            });
            $("#addressInputForm").keyup(function (event) {
                resizeRelevantModeZeroCheck(event, "#addressInputForm");
            });
            map = new GMaps({
                div: '#fooForm',
                lat: 60.0,
                lng: -77.02833,
                width: '500px',
                height: '500px'
            });
            GMaps.geolocate({
                success: function (position) {
                    map.setCenter(position.coords.latitude, position.coords.longitude);
                },
                error: function (error) {
                    alert('Geolocation failed: ' + error.message);
                },
                not_supported: function () {
                    alert("Your browser does not support geolocation");
                },
                always: function () {
                }
            });
            var jsonHits;
            $.ajax({
                //Template ajax-query to connect JQuery with Spring using
                //JSON
                url: "userForm/requestHits",
                type: "GET",
                dataType: "json",
                success: function asdf(data) {
                    jsonHits = data;
                    $.each(data, function (i, val) {
                        map.addMarker({
                            lat: val.latitude,
                            lng: val.longitude,
                            title: val.name + " " + val.id + " " + val.address,
                            click: function (e) {
                            }
                        });
                    });
                }
            });
            var accuiredHover = false;
            $("#fooForm").hover(function (event) {
                function recenter() {
                    var currentCentering = map.getCenter();
                    map.setCenter(currentCentering.G, currentCentering.K, function () {
                    });
                }
                var beforeAccuirementCentering = map.getCenter();
                $("#fooForm").animate({
                    width: '100%',
                    height: '500px'
                }, 30, function () {
                    if (accuiredHover == false) {
                        accuiredHover = true;
                        map = new GMaps({
                            div: '#fooForm',
                            lat: beforeAccuirementCentering.lat(),
                            lng: beforeAccuirementCentering.lng(),
                            width: '100%',
                            height: '500px'
                        });
                        $.each(jsonHits, function (i, val) {
                            map.addMarker({
                                lat: val.latitude,
                                lng: val.longitude,
                                title: val.name + " " + val.id + ".  " + val.address,
                                click: function (e) {
                                }
                            });
                        });
                    }
                });
            }, function (event) {
                accuiredHover = false;
                $("#fooForm").animate({
                    width: '500px',
                    height: '500px'
                });
            });
            $("#button").click(function (event) {
                event.preventDefault();
                var geoCoder = new google.maps.Geocoder();
                var name = $("#nameinput").val();
                var id = $("#idinputForm").val();
                var address = $("#addressInputForm").val();
                $("#nameinput").val("");
                $("#idinputForm").val("");
                $("#addressInputForm").val("");
                geoCoder.geocode({'address': address}, function (results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                        jsonString = {
                            "name": name,
                            "id": id,
                            "address": address,
                            "latitude": results[0].geometry.location.lat(),
                            "longitude": results[0].geometry.location.lng()
                        };
                        alert(results);
                        jsonHits.push(jsonString);
                        map.addMarker({
                            lat: results[0].geometry.location.lat(),
                            lng: results[0].geometry.location.lng(),
                            title: name + " " + id + " cm " + address,
                            click: function (e) {
                                alert(val.name + " " + val.id + " " + val.address);
                            }
                        });
                        $.ajax({
                            //Template ajax-query to connect JQuery with Spring using
                            //JSON
                            contentType: "application/json",
                            url: "userForm",
                            data: JSON.stringify(jsonString),
                            type: "POST",
                            dataType: "html",
                            success: function asdf(data) {
                            }
                        });
                    } else {
                        alert("Not working");
                    }
                });
            });
            function openSubMenu() {
                $('#countryBox').stop(true, true).slideDown('fast');

            };
            function closeSubMenu() {
                $('#countryBox').stop(true, true).slideUp('fast');
            };
            $('#browseBox').hover(function () {
                $('#countryBox').css("visibility", "visible");
                openSubMenu();
            }, function () {
                closeSubMenu();
            });
            function centerMap(latitude, longitude) {
                map.setCenter(latitude, longitude);
            };

            $('#finland').click(function (event) {
                event.preventDefault();
                centerMap(60.192059, 24.945831);
            });
            $('#sweden').click(function (event) {
                event.preventDefault();
                centerMap(59.332631, 18.063425);
            });
            $('#estonia').click(function () {
                event.preventDefault();
                centerMap(63.228341, 18.06345);
            });
        });
    </script>
</head>
<link rel="stylesheet" href="/resources/tyyliTiedosto.css"/>
<body>
<ul>
    <li id="browseBox">Selaa paikallisia havaintoja
        <ul id="countryBox">
            <li><a href="" id="finland">Suomi</a> </li>
            <li><a href="" id="sweden">Ruotsi</a></li>
            <li><a href="" id="norway">Norja</a></li>
        </ul>
    </li>
    <Li>Tietoja</Li>
</ul>
<br>
<br>
<div id="formDiv">
    <div id="nanmeInput">Havainto<br></div>
    <input type="text" id="nameinput" width="500px">
    <br>

    <div id="idInput">Aika<br></div>
    <input type="text" id="idinputForm" width="500px">

    <div id="addressInput">Osoite</div>
    <input type="text" id="addressInputForm" width="500px">
    <br>
    <button id="button">Havaitse</button>
</div>
<div id="map_container"></div>
<div id="fooForm"></div>
</body>
</html>
