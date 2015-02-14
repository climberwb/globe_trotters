// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap
//= require d3


$(function() {
  //chat!
  // var faye = new Faye.Client('http://localhost:9292/faye');
  // faye.subscribe('/messages/new', function (data) {
  //    eval(data);
  // });

// location for teams
// $('#location-list li').click(function(event){
//        alert($(this)[0].innerHTML);
//     });

//way to get the json string

// var jqxhr = $.get( "/teams/to_geo_json", function(data) {
//   alert( "success" );
// })
//   .done(function(d) {
//     alert( JSON.stringify(d.features) );
//     //alert( JSON.stringify(d.features[0].properties.TeamName) );
//   })
//   .fail(function() {
//     alert( "error" );
//   })
//   .always(function() {
//     alert( "finished" );
//   });

//adding tool-tip
var tooltip = d3.select("body")
    .append("div").attr("id", "tool_tip").style("position", "absolute")
    .style("z-index", "10")
    .style("visibility", "hidden")
    .style("background-color", "yellow")//.style("top","100px").style("left","20px")
    .text("a simple tooltip");//.append("img").attr("src","http://www.metmuseum.org/~/media/Images/Metpublication/Cover/2004/Echoing_Images_Couples_in_African_Sculpture.jpg");

var image = tooltip.append("img").attr("src","");
   // tooltip.style("position", "absolute")
   //  .style("z-index", "10")
   //  .style("visibility", "hidden")
   //  .style("background-color", "yellow")//.style("top","100px").style("left","20px")
   //  .text("a simple tooltip");//.image;

    tooltip.text("my tooltip text");
//spining globe
d3.select(window)
    .on("mousemove", mousemove)
    .on("mouseup", mouseup);
//scales the svg
var width = 960*1.5/2,
    height = 500*2.3/2;
//takes care of the height and width of globe
var proj = d3.geo.orthographic()
    .translate([width / 2, height / 2])
    .clipAngle(90)
    .scale(220*2.3/2);
//takes care of the height and width of globe
var sky = d3.geo.orthographic()
    .translate([width / 2, height / 2])
    .clipAngle(90)
    .scale(300*2.3/2);

var path = d3.geo.path().projection(proj).pointRadius(2);

var swoosh = d3.svg.line()
      .x(function(d) { return d[0] })
      .y(function(d) { return d[1] })
      .interpolate("cardinal")
      .tension(.0);

var links = [],
    arcLines = [];

var svg = d3.select("body").append("svg")
            .attr("width", width)
            .attr("height", height).attr("class",'img-responsive')
            .on("mousedown", mousedown);
queue()
    .defer(d3.json, "/assets/world-110m.json")
    .defer(d3.json, "/teams/to_geo_json")
    .await(ready);

function ready(error, world, places) {
  var ocean_fill = svg.append("defs").append("radialGradient")
        .attr("id", "ocean_fill")
        .attr("cx", "75%")
        .attr("cy", "25%");
      ocean_fill.append("stop").attr("offset", "5%").attr("stop-color", "#fff");
      ocean_fill.append("stop").attr("offset", "100%").attr("stop-color", "#ababab");

  var globe_highlight = svg.append("defs").append("radialGradient")
        .attr("id", "globe_highlight")
        .attr("cx", "75%")
        .attr("cy", "25%");
      globe_highlight.append("stop")
        .attr("offset", "5%").attr("stop-color", "#ffd")
        .attr("stop-opacity","0.6");
      globe_highlight.append("stop")
        .attr("offset", "100%").attr("stop-color", "#ba9")
        .attr("stop-opacity","0.2");

  var globe_shading = svg.append("defs").append("radialGradient")
        .attr("id", "globe_shading")
        .attr("cx", "55%")
        .attr("cy", "45%");
      globe_shading.append("stop")
        .attr("offset","30%").attr("stop-color", "#fff")
        .attr("stop-opacity","0")
      globe_shading.append("stop")
        .attr("offset","100%").attr("stop-color", "#505962")
        .attr("stop-opacity","0.3")
//gives it a shaodow
  var drop_shadow = svg.append("defs").append("radialGradient")
        .attr("id", "drop_shadow")
        .attr("cx", "50%")
        .attr("cy", "50%");
      drop_shadow.append("stop")
        .attr("offset","20%").attr("stop-color", "#000")
        .attr("stop-opacity",".5")
      drop_shadow.append("stop")
        .attr("offset","100%").attr("stop-color", "#000")
        .attr("stop-opacity","0")
//moves the shadow
  svg.append("ellipse")
    .attr("cx", 440*1.5).attr("cy", 450*1.5)
    .attr("rx", proj.scale()*.90*1.5)
    .attr("ry", proj.scale()*.25*1.5)
    .attr("class", "noclicks")
    .style("fill", "url(#drop_shadow)");

  // svg.append("circle")
  //   .attr("cx", width / 2).attr("cy", height / 2)
  //   .attr("r", proj.scale())
  //   .attr("class", "noclicks")
  //   .style("fill", "url(#ocean_fill)");

  svg.append("path")
    .datum(topojson.object(world, world.objects.land))
    .attr("class", "land noclicks")
    .attr("d", path);

  svg.append("circle")
    .attr("cx", width / 2).attr("cy", height / 2)
    .attr("r", proj.scale())
    .attr("class","noclicks")
    .style("fill", "url(#globe_highlight)");

  svg.append("circle")
    .attr("cx", width / 2).attr("cy", height / 2)
    .attr("r", proj.scale())
    .attr("class","noclicks")
    .style("fill", "url(#globe_shading)");

  svg.append("g").attr("class","points")
      .selectAll("text").data(places.features)
    .enter().append("path")
      .attr("class", "point")
      .attr("d", path);
  // spawn links between cities as source/target coord pairs
  places.features.forEach(function(a) {
    places.features.forEach(function(b) {
      if (a !== b) {
        links.push({
          source: a.geometry.coordinates,
          target: b.geometry.coordinates
        });
      }
    });
  });

  // build geoJSON features from links array
  links.forEach(function(e,i,a) {
    var feature =   { "type": "Feature", "geometry": { "type": "LineString", "coordinates": [e.source,e.target] }}
    arcLines.push(feature)
  })

  svg.append("g").attr("class","arcs")
    .selectAll("path").data(arcLines)
    .enter().append("path")
      .attr("class","arc")
      .attr("d",path)

  svg.append("g").attr("class","flyers")
    .selectAll("path").data(links)
    .enter().append("path")
    .attr("class","flyer")
    .attr("d", function(d) { return swoosh(flying_arc(d)) })

// append information upon hover ////////////////////


     svg.append("g").attr("class","points")
      .selectAll("text").data(places.features)
    .enter().append("path").attr("r", function(d){return 1234567})
      .attr("class", "point")
      .on("mouseover", function(d) {
          var div = document.getElementById('profile');
          var test = $('#test').text();
          div.innerHTML = "";
          div.innerHTML = div.innerHTML + d3.event.pageY+ ' X:'+d3.event.pageX +'<img src='+test+'>';

          $('#tool_tip').css("top",d3.event.pageY);
          $('#tool_tip').css("left",d3.event.pageX);


          $('#tool_tip').css("visibility", "visible");
          $('#tool_tip img').css("visibility", "visible");
          $('#tool_tip img').css("top",d3.event.pageY);
          var tool_tip = $('#tool_tip');
            
         // alert($(this).attr('d'));

          var j = places.features[0].properties.name
          //adding text to tool tip by different points
         // alert(JSON.stringify(d.properties.TeamName));
        // alert(JSON.stringify(d));
          //$('#tool_tip').text(d.properties[0].TeamName);
          return tooltip.html("<a href="+d.properties[0].TeamProfileUrl+">"+d.properties[0].TeamName+"</a>"+"<img src = "+d.properties[0].TeamPicUrl+">");
         // return tooltip;//.style("visibility", "visible");
        //Warren you need to build out the pop up here.  Ideally you can pull the data from the json object "places.json."

      });

  refresh();
}

function flying_arc(pts) {
  var source = pts.source,
      target = pts.target;

  var mid = location_along_arc(source, target, .5);
  var result = [ proj(source),
                 sky(mid),
                 proj(target) ]
  return result;
}



function refresh() {
  svg.selectAll(".land").attr("d", path);
  svg.selectAll(".point").attr("d", path);

  svg.selectAll(".arc").attr("d", path)
    .attr("opacity", function(d) {
        return fade_at_edge(d)
    })

  svg.selectAll(".flyer")
    .attr("d", function(d) { return swoosh(flying_arc(d)) })
    .attr("opacity", function(d) {
      return fade_at_edge(d)
    })
}

function fade_at_edge(d) {
  var centerPos = proj.invert([width/2,height/2]),
      arc = d3.geo.greatArc(),
      start, end;
  // function is called on 2 different data structures..
  if (d.source) {
    start = d.source,
    end = d.target;
  }
  else {
    start = d.geometry.coordinates[0];
    end = d.geometry.coordinates[1];
  }

  var start_dist = 1.57 - arc.distance({source: start, target: centerPos}),
      end_dist = 1.57 - arc.distance({source: end, target: centerPos});

  var fade = d3.scale.linear().domain([-.1,0]).range([0,.1])
  var dist = start_dist < end_dist ? start_dist : end_dist;

  return fade(dist)
}

function location_along_arc(start, end, loc) {
  var interpolator = d3.geo.interpolate(start,end);
  return interpolator(loc)
}

// modified from http://bl.ocks.org/1392560
var m0, o0;
function mousedown() {
  m0 = [d3.event.pageX, d3.event.pageY];
  o0 = proj.rotate();
  d3.event.preventDefault();
}
function mousemove() {
  if (m0) {
    var m1 = [d3.event.pageX, d3.event.pageY]
      , o1 = [o0[0] + (m1[0] - m0[0]) / 6, o0[1] + (m0[1] - m1[1]) / 6];
    o1[1] = o1[1] > 30  ? 30  :
            o1[1] < -30 ? -30 :
            o1[1];
    proj.rotate(o1);
    sky.rotate(o1);
    refresh();
  }
}
function mouseup() {
  if (m0) {
    mousemove();
    m0 = null;
  }
}

// here is the .tsv code

 // var tip = d3.tip().attr('class', 'd3-tip').offset([-10, 0]).html(function(d) {    return "<strong>Frequency:</strong> <span style='color:red'>" + d.frequency + "</span>";  })


 // svg.call(tip);


// d3.tsv("data.tsv", type, function(error, data){  x.domain(data.map(function(d) { return d.letter; }));  y.domain([0, d3.max(data, function(d) { return d.frequency; })]);


// svg.selectAll(".bar").data(data).enter().append("rect").attr("class", "bar").attr("x", function(d) { return x(d.letter); }).attr("width", x.rangeBand()).attr("y", function(d) { return y(d.frequency); }).attr("height", function(d) { return height - y(d.frequency); }).on('mouseover', tip.show).on('mouseout', tip.hide)
// function type(d){  d.frequency =+ d.frequency;  return d;}

// try to animate this code makes it so you cannot move the globe, fix this!


startAnimation();
function startAnimation() {
  var y = 1;
  done=false;

  d3.timer(function() {
    if(!mousemove() || !mouseup() || !mousedown()){
    proj.rotate([y,-18]);
    sky.rotate([y,-18]);
  //d3.event.preventDefault();
    y++;
    refresh();
    return done;
  }

  });

}
});