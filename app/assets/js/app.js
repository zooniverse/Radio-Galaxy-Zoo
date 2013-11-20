(function(/*! Brunch !*/) {
  'use strict';

  var globals = typeof window !== 'undefined' ? window : global;
  if (typeof globals.require === 'function') return;

  var modules = {};
  var cache = {};

  var has = function(object, name) {
    return ({}).hasOwnProperty.call(object, name);
  };

  var expand = function(root, name) {
    var results = [], parts, part;
    if (/^\.\.?(\/|$)/.test(name)) {
      parts = [root, name].join('/').split('/');
    } else {
      parts = name.split('/');
    }
    for (var i = 0, length = parts.length; i < length; i++) {
      part = parts[i];
      if (part === '..') {
        results.pop();
      } else if (part !== '.' && part !== '') {
        results.push(part);
      }
    }
    return results.join('/');
  };

  var dirname = function(path) {
    return path.split('/').slice(0, -1).join('/');
  };

  var localRequire = function(path) {
    return function(name) {
      var dir = dirname(path);
      var absolute = expand(dir, name);
      return globals.require(absolute, path);
    };
  };

  var initModule = function(name, definition) {
    var module = {id: name, exports: {}};
    cache[name] = module;
    definition(module.exports, localRequire(name), module);
    return module.exports;
  };

  var require = function(name, loaderPath) {
    var path = expand(name, '.');
    if (loaderPath == null) loaderPath = '/';

    if (has(cache, path)) return cache[path].exports;
    if (has(modules, path)) return initModule(path, modules[path]);

    var dirIndex = expand(path, './index');
    if (has(cache, dirIndex)) return cache[dirIndex].exports;
    if (has(modules, dirIndex)) return initModule(dirIndex, modules[dirIndex]);

    throw new Error('Cannot find module "' + name + '" from '+ '"' + loaderPath + '"');
  };

  var define = function(bundle, fn) {
    if (typeof bundle === 'object') {
      for (var key in bundle) {
        if (has(bundle, key)) {
          modules[key] = bundle[key];
        }
      }
    } else {
      modules[bundle] = fn;
    }
  };

  var list = function() {
    var result = [];
    for (var item in modules) {
      if (has(modules, item)) {
        result.push(item);
      }
    }
    return result;
  };

  globals.require = require;
  globals.require.define = define;
  globals.require.register = define;
  globals.require.list = list;
  globals.require.brunch = true;
})();
require.register("content/biographies", function(exports, require, module) {
module.exports = [
  {
    name: "Ivy Wong",
    title: "Project Scientist: Astronomer",
    institution: "CSIRO Astronomy and Space Science, Australia",
    location: "Australia",
    twitter: "owning_ivy",
    bio: "A science team member of the Galaxy Zoo project whose research interests revolve around what causes galaxies to start and to stop forming stars.  She is interested in galaxies that have suddenly stopped forming stars (aka ‘post-starburst’ galaxies) and blue spheroidal galaxies. Therefore, she is very keen to find out how the massive radio jets emitting from central supermassive black holes affect its host galaxy as well as neighbouring galaxies."
  }, {
    name: "Melanie Gendre",
    institution: "Jodrell Bank Center for Astrophysics",
    twitter: null,
    bio: null
  }, {
    name: "Steven Bamford",
    institution: "University of Nottingham",
    twitter: "thebamf",
    bio: null
  }, {
    name: "Julie Banfield",
    title: "Astronomer",
    institution: "CSIRO Astronomy and Space Science, Australia, Australia",
    twitter: "42jkb",
    bio: "Julie is interested in the evolution of radio galaxies and how they impact their surrounding environment as they grow and evolve.  She is excited about Radio Galaxy Zoo as it will provide the necessary link between the radio galaxy and the host galaxy required to solve the puzzle of radio galaxy evolution.  Julie also participates in Scientists in Schools and is keen to get her students and teachers involved in Radio Galaxy Zoo."
  }, {
    name: "Tania Burchell",
    institution: "National Radio Astronomy Observatory",
    twitter: null,
    bio: null
  }, {
    name: "Loretta Dunne",
    institution: "University of Nottingham",
    twitter: null,
    bio: null
  }, {
    name: "Lucy Fortson",
    title: "Astrophysicist",
    institution: "University of Minnesota",
    twitter: null,
    bio: "Interested in galaxy evolution, black holes and the jets of material beaming from the centers of active galactic nuclei. We need radio galaxy zoo data to help us understand these jets! Started the Zooniverse effort at the Adler Planetarium, now bringing the light to the University of Minnesota. On the odd weekend, when she's not preparing lecture or writing grants, Lucy can be found hanging out with her husband and son at one of Minneapolis' fine dining establishments."
  }, {
    name: "Samuel George",
    institution: "University of Cambridge",
    twitter: null,
    bio: null
  }, {
    name: "Ian Heywood",
    institution: "Oxford University",
    twitter: null,
    bio: null
  }, {
    name: "Robert Hollow",
    title: "Astronomy Educator",
    institution: "CSIRO Astronomy and Space Science, Australia",
    location: "Australia",
    twitter: null,
    bio: "Robert is an Education and Outreach specialist with CSIRO Astronomy and Space Science, Australia. He is interested in how the public and schools students interact with and interpret radio astronomy data using citizen science. The feedback from this project will help guide the development of future projects utilising the massive data sets from ASKAP and the SKA. He also coordinates the PULSE@Parkes project where students use the Parkes radio telescope to observe pulsars."
  }, {
    name: "Matt Jarvis",
    institution: "University of Hertfordshire",
    twitter: null,
    bio: null
  }, {
    name: "Hans-Rainer Klöckner",
    institution: "Max-Planck-Institut für Radioastronomie",
    twitter: null,
    bio: null
  }, {
    name: "Chris Lintott",
    institution: "Oxford University",
    twitter: "chrislintott",
    bio: "Runs the Zooniverse collaboration and works on how galaxies form and evolve; particularly interested in the effects of active galactic nuclei and mergers. In his 'spare' time, he hunts for planets, presents the BBC's long-running Sky at Night program and cooks."
  }, {
    name: "Vicky Lo",
    institution: "CSIRO Astronomy and Space Space",
    twitter: null,
    bio: null
  }, {
    name: "Minnie Mao",
    institution: "NRAO",
    twitter: null,
    bio: null
  }, {
    name: "Karen Masters",
    title: "Astronomer",
    institution: "Institute of Cosmology and Gravitation, University of Portsmouth",
    twitter: "KarenLMasters",
    bio: "Karen is the Project Scientist for Galaxy Zoo. Her research uses data from large surveys to search for clues as to how galaxies form and evolve - she’s particularly worked on red spirals, and galactic bars in recent years using classifications from Galaxy Zoo. Karen has a background in radio astronomy (her first telescope was Arecibo - http://www.naic.edu/general/) and is really excited to see Galaxy Zoo expand into radio frequencies."
  }, {
    name: "Enno Middelberg",
    title: "Astronomer",
    institution: "Ruhr-University Bochum",
    twitter: null,
    bio: "Enno's main interest is galaxy evolution and the role that Active Galactic Nuclei play. He has helped develop new observational methods to connect radio telescopes from all over the world (Very Long Baseline Interferometry, or VLBI) and to simultaneously observe hundreds of RGZoo objects with these telescopes. For the Radio Zoo project in its beta phase, Enno has generated the radio contour and infrared heatmap images from the original FITS data."
  }, {
    name: "Ray Norris",
    title: "Chief Research Scientist",
    institution: "CSIRO Astronomy and Space Space",
    twitter: null,
    bio: "Ray researches how galaxies formed and evolved after the Big Bang, using radio, infrared, and optical telescopes. As a sideline, he also researches the astronomy of Australian Aboriginal people, frequently appears on radio and TV, and has recently published a novel, Graven Images. His current all-consuming task is to lead the Evolutionary Map of the Universe (EMU) project to image the faintest radio galaxies in the Universe, using the new ASKAP radio telescope being built in Western Australia. EMU will multiply mankind’s knowledge of the radio sky from about 2.5 million radio sources to about 70 million, but to turn that data into understanding will require us to cross-match them against images from optical and infrared telescopes."
  }, {
    name: "Larry Rudnick",
    title: "Distinguished Teaching Professor",
    institution: "University of Minnesota",
    location: "Minnesota, United States",
    twitter: null,
    bio: "Larry has been classifying radio galaxies since the mid-70s. He's saturated, and is thrilled with this effort to bring lots of fresh eyes to the massive new samples coming from modern radio telescopes. Larry's research work has focussed on radio galaxies, clusters of galaxies and supernova remnants, combining data from many different wavebands. He was a frequent on-screen expert for U.S. Public Television's Newton’s Apple and has been heavily involved in training elementary school teachers to use hands-on science and in working with local planetariums."
  }, {
    name: "Kevin Schawinski",
    title: "Assistant Professor",
    institution: "ETH Institute for Astronomy",
    location: "Zurich, Switzerland",
    twitter: "kevinschawinski",
    bio: "Kevin's research interests span the formation of galaxies and how black holes can change the evolutionary destinies as well as where supermassive black holes came from in the first place. The original Galaxy Zoo project came out of Kevin’s Ph.D thesis at Oxford University, where he was classifying galaxies by himself and needed some help."
  }, {
    name: "Nick Seymour",
    institution: "CSIRO Astronomy and Space Science, Australia",
    twitter: null,
    bio: null
  }, {
    name: "Stas Shabala",
    institution: "University of Tasmania",
    twitter: null,
    bio: null
  }, {
    name: "Arfon Smith",
    institution: "Adler Planetarium",
    twitter: "arfon",
    bio: "As an undergraduate, Arfon studied Chemistry at the University of Sheffield before completing his Ph.D. in Astrochemistry at The University of Nottingham in 2006. He worked as a senior developer at the Wellcome Trust Sanger Institute (Human Genome Project) in Cambridge before joining the Galaxy Zoo team in Oxford. Over the past 3 years he has been responsible for leading the development of a platform for citizen science called Zooniverse. In August of 2011 he took up the position of Director of Citizen Science at the Adler Planetarium where he continues to lead the software and infrastructure development for the Zooniverse."
  }, {
    name: "Kyle Willett",
    title: "Astronomer",
    institution: "University of Minnesota",
    location: "Minnesota, United States",
    twitter: "kwwillett",
    bio: "Kyle has either been studying galaxies, using radio telescopes, or working with citizen science projects for his entire astronomical career so far. As a result, he’s particularly excited about Radio Galaxy Zoo. As a postdoctoral researcher at UMN, he led the analysis and reduction of the Galaxy Zoo 2 project as well as helping to design and implement new analysis tools for the Zooniverse volunteers. He’s interested in the connection between massive radio jets and the black holes producing them, and understanding the physics that bridge the gap between such massive spatial scales."
  }, {
    name: "Laura Whyte",
    title: "Educator and Developer",
    institution: "Adler Planetarium",
    twitter: "whytewithawhy",
    bio: "As a former high school teacher and adult educator, with a PhD in galaxy classification (seriously), joining the Zooniverse as an educator was a natural fit for Laura. Based at the Adler Planetarium in Chicago, she's working to encourage and support teachers to use Zooniverse citizen science projects in the classroom."
  }, {
    name: "Heinz Andernach",
    institution: "University of Guanajuato, Mexico",
    twitter: null,
    bio: "Heinz has been studying radio galaxies since the late 1970's, mainly those    in clusters of galaxies.  Over the past 25 years he has been collecting (or    digitizing by himself) the radio source lists of over 2000 different    research papers with the aim (still pending) to create the largest    public database on celestial radio sources. Recently he supervised two    summer students to visually inspect three radio surveys (NVSS, SUMSS and    WENSS) that cover the entire sky to search for emission features likely    to indicate giant radio galaxies. In only six weeks they were able to    duplicate the number of known such objects from 100 to 200, even finding    the yet largest of these with a diameter of 19 million light years. He    is eager to know what thousands of eyes on the radio sky can reveal."
  }, {
    name: "Robert Simpson",
    institution: "Oxford University",
    twitter: "orbitingfrog",
    bio: "Rob is a researcher and web developer as well as Communicatios Lead for the Zooniverse. His background is in submillimetre astronomy so he's quite used to seeing the kind of 'fried eggs' that Radio Gaalxy Zoo has to offer. Rob is also interested in the Zooniverse itself and the motivations of the hundreds of thousands of amazing people who come and classify on sites like Radio Galaxy Zoo. You can follow Rob online at orbitingfrog.com."
  }, {
    name: "Ed Paget",
    institution: "Adler Planetarium",
    twitter: "edpaget",
    bio: ""
  }, {
    name: "Brooke Simmons",
    institution: "Oxford University",
    twitter: "vrooje",
    bio: ""
  }
];
});

;require.register("content/tutorial_steps", function(exports, require, module) {
var Step, addBlock, checkState, disableButtons, groupid, removeBlock;

Step = zootorial.Step;

addBlock = function() {
  var el;
  el = angular.element(document.querySelector(".viewport"));
  el.addClass("block");
  el = angular.element(document.querySelector("span.toggle-contours"));
  return el.addClass("block");
};

removeBlock = function() {
  var el;
  el = angular.element(document.querySelector(".viewport"));
  el.removeClass("block");
  el = angular.element(document.querySelector("span.toggle-contours"));
  return el.removeClass("block");
};

disableButtons = function() {
  var els;
  return els = angular.element(document.querySelectorAll(".workflow .buttons button"));
};

groupid = null;

checkState = null;

module.exports = {
  stage1: {
    length: 13,
    welcome: new Step({
      number: 1,
      header: "Welcome to Radio Galaxy Zoo!",
      details: "We’re going to show you two images of the same part of the sky, one from a radio telescope and one from an infrared telescope. \n \n Most contain galaxies that will show in the infrared (IR), but only some galaxies appear in the radio.",
      attachment: "center center .viewport center center",
      next: "wavelengths"
    }),
    wavelengths: new Step({
      number: 2,
      header: "Different Wavelengths",
      details: "Here are two galaxies seen at radio wavelengths - we use contours to show their radio brightness. To see how the galaxies appear in the infrared, move the slider over to the IR position. The goal is to match up the radio contours to their galaxy images in the IR.",
      attachment: "center -0.05 .image-opacity center bottom",
      className: "arrow-top",
      next: "classify1"
    }),
    classify1: new Step({
      number: 3,
      header: "Paring the Data",
      details: "Let’s do the easy galaxy first: pick the smaller object by clicking on its contours.",
      attachment: "-0.15 0.35 #2.contour-group right center",
      className: "arrow-left",
      next: {
        'click #2.contour-group': 'classify2'
      }
    }),
    classify2: new Step({
      number: 4,
      header: "Pairing the Data",
      details: "Now select it in the infrared too. Use the slider to compare the two. In this case the galaxy is at exactly the same position in both wavelengths.",
      attachment: "-0.15 0.35 #2.contour-group right center",
      next: {
        'click svg': "classify3"
      },
      className: "arrow-left"
    }),
    classify3: new Step({
      number: 5,
      header: "Pairing the Data",
      details: "Now click 'Done'",
      attachment: "right 0.55 .done left center",
      className: "arrow-right",
      next: {
        'click .done': "classify4"
      }
    }),
    classify4: new Step({
      number: 6,
      header: "Pairing the Data",
      details: "Now let's mark the other Galaxy. First select 'Mark Another Source'",
      attachment: "left 0.65 .next-radio right center",
      className: "arrow-left",
      next: {
        'click .next-radio': "classify5"
      }
    }),
    classify5: new Step({
      number: 7,
      header: "Pairing the Data",
      details: "Now let’s click the contours of the brighter galaxy",
      attachment: "-0.4 -0.5 #1.contour-group right center",
      className: "arrow-left",
      next: {
        'click #1.contour-group': "classify6"
      }
    }),
    classify6: new Step({
      number: 8,
      header: "Pairing the Data",
      details: "When you check the infrared you’ll see a galaxy between the two bright radio ‘lobes’.",
      attachment: "-0.4 -0.5 #1.contour-group right center",
      className: "arrow-left",
      next: {
        'click svg': "classify7"
      }
    }),
    classify7: new Step({
      number: 9,
      header: "Pairing the Data",
      details: "Click the object and select 'Done'",
      attachment: "right 0.55 .done left center",
      className: "arrow-right",
      next: {
        'click .done': "classify8"
      }
    }),
    classify8: new Step({
      number: 10,
      header: "Pairing the Data",
      details: "That's all the pairs in this image. Click 'Finish' to advance.",
      attachment: "right 0.55 .done left center",
      className: "arrow-right",
      next: {
        'click .done': 'que'
      }
    }),
    que: new Step({
      number: 11,
      header: "What's Going on?",
      details: "The fainter radio object shows emission from newly-formed stars in the galaxy. The bright radio object shows us two jets emitted by a supermassive black hole at center of that galaxy -- but we can only see the central galaxy in the infrared. \n \n This is why we need your help to match these objects.",
      attachment: "right center .viewport left center",
      next: 'guide'
    }),
    guide: new Step({
      number: 12,
      header: "More Objects",
      details: "You can see many more examples in the ‘Guide’, showing how the science team marked more complex objects.",
      attachment: "0.35 0.20 .example-selection right center",
      className: "arrow-left",
      next: 'next'
    }),
    next: new Step({
      number: 13,
      header: "Next",
      details: "You can favourite images to see again later, or discuss images with the community on our forum, Talk. \n \n Click ‘Next’ to move on to the next image. ",
      attachment: "right 0.55 .next left center",
      className: "arrow-right",
      next: {
        "click .next": null
      }
    })
  }
};
});

;require.register("content/tutorial_subject", function(exports, require, module) {
var Subject;

Subject = zooniverse.models.Subject;

module.exports = {
  stage1: {
    id: "520be919e4bb21ddd30000c9",
    project_id: "520be12ce4bb21ddcd000001",
    workflow_ids: ["520be12ce4bb21ddcd000002"],
    location: {
      standard: "http://radio.galaxyzoo.org/beta/subjects/standard/S311.jpg",
      radio: "http://radio.galaxyzoo.org/beta/subjects/radio/S311.jpg",
      raw: "//radio.galaxyzoo.org/beta/subjects/raw/S311.fits.gz"
    },
    coords: [9.33480833333, -44.1265305556],
    metadata: {
      src: "S311",
      cid: "C0311, C0311.1",
      swire: "J003720.35-440735.5"
    },
    zooniverse_id: "ARG000005m",
    tutorial: true
  }
};
});

;require.register("controllers/classifier", function(exports, require, module) {
var Classifier, Subject;

Subject = zooniverse.models.Subject;

Classifier = function($scope, model) {
  var contourid, path, _i, _len, _ref;
  $scope.model = model;
  $scope.showContours = model.showContours;
  $scope.step = model.step;
  $scope.showSED = model.showSED;
  $scope.example = model.example;
  $scope.subExample = model.subExample;
  $scope.getInfraredSource = function() {
    return model.infraredSource;
  };
  $scope.getRadioSource = function() {
    return model.radioSource;
  };
  $scope.getStep = function() {
    return model.step;
  };
  $scope.getShowContours = function() {
    return model.showContours;
  };
  $scope.getNextInfraredSource = function() {
    return model.nextInfraredSource;
  };
  $scope.getNextRadioSource = function() {
    return model.nextRadioSource;
  };
  $scope.getExample = function() {
    return model.example;
  };
  $scope.getIsDisabled = function() {
    return model.isDisabled;
  };
  $scope.getContourCount = function() {
    return model.matches.length === 0;
  };
  $scope.getGuide = function() {
    return model.activeGuide;
  };
  if (model.subjectContours.length > 0) {
    if (model.hasTutorial) {
      model.startFirstTutorial();
    }
    model.drawContours(model.subjectContours[0]);
    _ref = model.selectedContours;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      contourid = _ref[_i];
      path = d3.select("path[contourid='" + contourid + "']");
      path.attr("class", "svg-contour selected");
    }
  }
  $scope.onTutorial = function() {
    model.resetMarking();
    model.step = 0;
    return model.onUserChange();
  };
  $scope.onCancel = function() {
    if (model.selectedContours.length !== 0) {
      model.resetMarking();
    }
    if (model.matches.length === 0) {
      return model.step = 0;
    } else {
      return model.step = 2;
    }
  };
  $scope.onNoCorrespondingFlux = function() {
    model.getMatch();
    model.showContours = true;
    return model.step = 3;
  };
  $scope.onNextRadio = function() {
    model.getMatch();
    return model.step = 0;
  };
  $scope.onDone = function() {
    model.getMatch();
    return model.step = 2;
  };
  $scope.onFinish = function() {
    model.showContours = true;
    model.ready = false;
    return model.step = 3;
  };
  $scope.onNext = function() {
    model.getClassification();
    model.getSubject();
    d3.select("g.contours").remove();
    d3.selectAll("g.infrared g").remove();
    model.step = 0;
    return model.showSED = false;
  };
  $scope.onFavorite = function(e) {
    angular.element(e.target).toggleClass("active");
    return model.toggleFavorite();
  };
  $scope.onDiscuss = function() {
    return alert("Sorry, Talk doesn't work yet");
  };
  return $scope.activateGuide = function() {
    return model.activeGuide = !model.activeGuide;
  };
};

module.exports = Classifier;
});

;require.register("controllers/science", function(exports, require, module) {
var Science;

Science = function($scope, $routeParams) {
  return $scope.category = $routeParams.category;
};

module.exports = Science;
});

;require.register("controllers/team", function(exports, require, module) {
var Biographies, Team;

Biographies = require('../content/biographies');

Team = function($scope) {
  $scope.team = Biographies.filter(function(d) {
    if (d.bio != null) {
      return d;
    }
  });
  return $scope.getTeamLength = function() {
    var _i, _ref, _results;
    return (function() {
      _results = [];
      for (var _i = 0, _ref = $scope.team.length; 0 <= _ref ? _i <= _ref : _i >= _ref; 0 <= _ref ? _i++ : _i--){ _results.push(_i); }
      return _results;
    }).apply(this);
  };
};

module.exports = Team;
});

;require.register("directives/example", function(exports, require, module) {
module.exports = function() {
  return {
    restrict: 'C',
    link: function(scope, elem, attrs) {
      return elem.on("click", function() {
        return scope.$apply(function() {
          return scope.model.example = elem.data().type;
        });
      });
    }
  };
};
});

;require.register("directives/image_opacity", function(exports, require, module) {
module.exports = function() {
  return {
    restrict: 'C',
    link: function(scope, elem, attrs) {
      var img, infraredEl, radioEl;
      img = document.querySelector("img.infrared");
      img = angular.element(img);
      img.css("opacity", 0);
      infraredEl = document.querySelector("p.band[data-band='infrared']");
      radioEl = document.querySelector("p.band[data-band='radio']");
      radioEl.onclick = function() {
        elem[0].value = 0;
        return elem[0].onchange();
      };
      infraredEl.onclick = function() {
        elem[0].value = 1;
        return elem[0].onchange();
      };
      elem[0].onmousedown = function() {
        return img.addClass("no-transition");
      };
      elem[0].onchange = function(e) {
        var value;
        value = elem[0].value;
        return img.css('opacity', value);
      };
      elem[0].onmouseup = function() {
        return img.removeClass("no-transition");
      };
      return scope.$watch('model.step', function(step) {
        if (step === 0) {
          return radioEl.onclick();
        } else if (step === 1 || step === 2 || step === 3) {
          return infraredEl.onclick();
        }
      });
    }
  };
};
});

;require.register("directives/marking", function(exports, require, module) {
module.exports = function() {
  return {
    restrict: 'C',
    link: function(scope, elem, attrs) {
      var create, dx, dy, img, infraredGroup, onDrag, onDragEnd, onDragStart, svg, translateRegEx;
      translateRegEx = /translate\((-?\d+), (-?\d+)\)/;
      svg = d3.select("svg.svg-contours");
      infraredGroup = d3.select("svg").append("g").attr("class", "infrared");
      dx = dy = null;
      img = document.querySelector("img.infrared");
      img = angular.element(img);
      elem = document.querySelector("input.image-opacity");
      onDragStart = function() {
        img.addClass("no-transition");
        if (scope.model.step !== 1) {
          return;
        }
        dx = d3.event.sourceEvent.layerX;
        return dy = d3.event.sourceEvent.layerY;
      };
      onDrag = function() {
        var value;
        value = parseFloat(elem.value) + d3.event.dx / 200;
        elem.value = value;
        return img.css("opacity", value);
      };
      onDragEnd = function() {
        var group, x, y;
        img.removeClass("no-transition");
        if (scope.model.step !== 1) {
          return;
        }
        if (d3.event.sourceEvent.target.tagName === "circle") {
          return;
        }
        x = d3.event.sourceEvent.layerX;
        y = d3.event.sourceEvent.layerY;
        dx -= x;
        dy -= y;
        if (dx === 0 && dy === 0) {
          group = infraredGroup.append("g").attr("transform", "translate(" + x + ", " + y + ")").attr("class", "");
          group.append("circle").attr("class", "annotation").attr("cx", 0).attr("cy", 0).attr("r", 10);
          group.append("circle").attr('class', 'remove').attr('cx', 7).attr('cy', -7).attr('r', 5).on('click', function() {
            return group.remove();
          });
          return group.append('text').text('x').attr('x', 5).attr('y', -5);
        }
      };
      create = d3.behavior.drag().on("dragstart", onDragStart).on("drag", onDrag).on("dragend", onDragEnd);
      return svg.call(create);
    }
  };
};
});

;require.register("directives/sub_example", function(exports, require, module) {
module.exports = function() {
  return {
    restrict: 'C',
    link: function(scope, elem, attrs) {
      return elem.on("click", function() {
        return scope.$apply(function() {
          return scope.model.subExample = elem.data().subexample;
        });
      });
    }
  };
};
});

;require.register("directives/toggle_contours", function(exports, require, module) {
module.exports = function() {
  return {
    restrict: 'C',
    link: function(scope, elem, attrs) {
      return elem[0].onclick = function(e) {
        return scope.$apply(function() {
          return scope.model.showContours = scope.model.showContours ? false : true;
        });
      };
    }
  };
};
});

;require.register("index", function(exports, require, module) {
var ClassifierCtrl, ClassifierModel, ExampleDirective, ImageOpacityDirective, MarkingDirective, RadioGalaxyZoo, ScienceCtrl, SubExampleDirective, TeamCtrl, ToggleContoursDirective, api, check, checkArrayBufferSlice, checkBlob, checkDataView, checkTypedArray, checkURL, checkWorker, classifierTemplate, footer, homeTemplate, host, profileTemplate, scienceTemplate, teamTemplate, topBar, _ref, _ref1;

console.log('here');

ClassifierCtrl = require('./controllers/classifier');

ScienceCtrl = require('./controllers/science');

TeamCtrl = require('./controllers/team');

ImageOpacityDirective = require('./directives/image_opacity');

MarkingDirective = require('./directives/marking');

ToggleContoursDirective = require('./directives/toggle_contours');

ExampleDirective = require('./directives/example');

SubExampleDirective = require('./directives/sub_example');

ClassifierModel = require('./services/ClassifierModel');

homeTemplate = require('./partials/home');

classifierTemplate = require('./partials/classifier');

profileTemplate = require('./partials/profile');

scienceTemplate = require('./partials/science');

teamTemplate = require('./partials/team');

RadioGalaxyZoo = angular.module("radio-galaxy-zoo", ['ngRoute']);

RadioGalaxyZoo.constant("imageDimension", 424);

RadioGalaxyZoo.constant("contourThreshold", 8);

RadioGalaxyZoo.constant("fitsImageDimension", 301);

RadioGalaxyZoo.constant("translateRegEx", /translate\((-?\d+), (-?\d+)\)/);

RadioGalaxyZoo.constant("levels", [3.0, 5.196152422706632, 8.999999999999998, 15.588457268119893, 26.999999999999993, 46.765371804359674, 80.99999999999997, 140.296115413079, 242.9999999999999, 420.88834623923697, 728.9999999999995, 1262.6650387177108, 2186.9999999999986, 3787.9951161531317, 6560.9999999999945]);

RadioGalaxyZoo.run(["classifierModel", function(classifierModel) {}]);

RadioGalaxyZoo.controller('ClassifierCtrl', ["$scope", "classifierModel", ClassifierCtrl]);

RadioGalaxyZoo.controller('ScienceCtrl', ["$scope", "$routeParams", ScienceCtrl]);

RadioGalaxyZoo.controller('TeamCtrl', ["$scope", TeamCtrl]);

RadioGalaxyZoo.directive('imageOpacity', ImageOpacityDirective);

RadioGalaxyZoo.directive('marking', MarkingDirective);

RadioGalaxyZoo.directive('toggleContours', ToggleContoursDirective);

RadioGalaxyZoo.directive('example', ExampleDirective);

RadioGalaxyZoo.directive('subExample', SubExampleDirective);

RadioGalaxyZoo.service('classifierModel', ["$rootScope", "$q", "translateRegEx", "imageDimension", "fitsImageDimension", "levels", "contourThreshold", ClassifierModel]);

host = window.location.port === "9296" ? "http://0.0.0.0:3000" : "https://dev.zooniverse.org";

if ((_ref = window.location.hostname) === "localhost" || _ref === "0.0.0.0" || _ref === "radio.galaxyzoo.org" || _ref === "192.168.50.1") {
  api = new zooniverse.Api({
    project: 'radio',
    host: host,
    path: '/proxy'
  });
} else {
  new Analytics({
    account: "UA-1224199-49"
  });
  api = new zooniverse.Api({
    project: 'radio',
    host: "https://api.zooniverse.org",
    path: '/proxy'
  });
}

topBar = new zooniverse.controllers.TopBar;

zooniverse.models.User.fetch();

topBar.el.appendTo('body');

footer = new zooniverse.controllers.Footer;

footer.el.appendTo('#footer');

checkDataView = window.DataView != null;

checkBlob = window.Blob != null;

checkWorker = window.Worker != null;

checkURL = window.URL || window.webkitURL;

checkTypedArray = window.Uint8Array != null;

checkArrayBufferSlice = ((_ref1 = window.ArrayBuffer) != null ? _ref1.prototype.slice : void 0) != null;

check = checkDataView && checkBlob && checkWorker && checkURL && checkTypedArray && checkArrayBufferSlice;

if (!check) {
  alert("Sorry, but your browser is not supported.");
}

RadioGalaxyZoo.config([
  '$routeProvider', function($routeProvider) {
    return $routeProvider.when("/home", {
      template: homeTemplate
    }).when("/classify", {
      template: classifierTemplate
    }).when("/science", {
      template: scienceTemplate
    }).when("/science/:category", {
      template: scienceTemplate
    }).when("/team", {
      template: teamTemplate
    }).when("/profile", {
      template: profileTemplate
    }).otherwise({
      redirectTo: "/home"
    });
  }
]);
});

;require.register("partials/classifier", function(exports, require, module) {
module.exports = "<div class=\"example-container\" data-ng-controller=\"ClassifierCtrl\">\n  <div data-ng-click=\"activateGuide()\" class=\"row example-selection\" ng-class=\"{'active': getGuide()}\">\n    Spotter's Guide\n  </div>\n  <div class=\"examples row\" ng-class=\"{'active': getGuide()}\">\n    <span class=\"col-xs-4 example\" ng-class=\"{'active': getExample()=='compact'}\" data-type=\"compact\">Compact</span>\n    <span class=\"col-xs-4 example\" ng-class=\"{'active': getExample()=='extended'}\" data-type=\"extended\">Extended</span>          \n    <span class=\"col-xs-4 example\" ng-class=\"{'active': getExample()=='multiple'}\" data-type=\"multiple\">Multiple</span>\n\n    <div class=\"row example-box\">\n      <div ng-switch on=\"getExample()\">\n        <div ng-switch-when=\"compact\">\n          <div class=\"row\">\n            <p>Category caption goes here.</p>\n          </div>\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/JwLkoWf.png\" / />\n          </div>\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/5I6c3X5.png\" />\n          </div>\n\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/CEkerlE.png\" />\n          </div>\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/NOsdJJ1.png\" />\n          </div>\n\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/lLTWokz.png\" />\n          </div>\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/HOVImG.png\" />\n          </div>\n        </div>\n\n        <div ng-switch-when=\"extended\">\n          <div class=\"row\">\n            <p>Category caption goes here.</p>\n          </div>\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/8MhmWG9.png\" />\n          </div>\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/4DC1WkO.png\" />\n          </div>\n\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/SBkzZMG.png\" />\n          </div>\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/rcRecZO.png\" />\n          </div>\n\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/V4TpnUN.png\" />\n          </div>\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/IqV2BLN.png\" />\n          </div>\n\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/53n1OGX.png\" />\n          </div>\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/ZitAkd0.png\" />\n          </div>\n\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/aiba51W.png\" />\n          </div>\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/BimKgCB.png\" />\n          </div>\n\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/uhI3xNz.png\" />\n          </div>\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/vbs1A2V.png\" />\n          </div>\n\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/0GZawBb.png\" />\n          </div>\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/fy8LHdK.png\" />\n          </div>\n\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/Ij5ClIS.png\" />\n          </div>\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/EWcIUe2.png\" />\n          </div>\n        </div>\n\n        <div ng-switch-when=\"multiple\">\n          <div class=\"row\">\n            <p>Category caption goes here.</p>\n          </div>\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/T0qP6Vo.png\" />\n          </div>\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/MuGZdqP.png\" />\n          </div>\n\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/uhMPY8Y.png\" />\n          </div>\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/eruqmTl.png\" />\n          </div>\n\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/6OBTkhC.png\" />\n          </div>\n          <div class=\"row\">\n            <img src=\"http://i.imgur.com/pmPhCkR.png\" />\n          </div>\n        </div>\n      </div>\n    </div>\n  </div>\n</div>\n\n<div class=\"classifier row\" data-ng-controller=\"ClassifierCtrl\">\n\n  <div class=\"workflow col-xs-6 col-centered\">\n    <div class=\"viewport col-centered\">\n      <img data-ng-src=\"{{ getRadioSource() }}\" />\n      <img class=\"infrared\" data-ng-src=\"{{ getInfraredSource() }}\" />\n\n      <div id=\"svg-contours\" class='contours marking step-{{getStep()}}' ng-class=\"{'fade-contour': !getShowContours()}\">\n        <svg xmlns=\"http://www.w3.org/2000/svg\" class=\"svg-contours\"></svg>\n      </div>\n      <span class=\"toggle-contours btn-primary {{getShowContours() ? '' : 'nocontours'}}\" title=\"{{getShowContours() ? 'Hide' : 'Show'}} Contours\"></span>\n      <span class=\"tutorial btn-primary\" data-ng-click=\"onTutorial()\" title=\"Tutorial\"></span>\n    </div>\n\n    <div class=\"row controls\">\n      <div class=\"image-slider col-xs-7\">\n        <p class=\"band\" data-band=\"radio\">Radio</p>\n        <input class='image-opacity' type=\"range\" min=\"0\" max=\"1\" step=\"0.01\" value=\"0\" />\n        <p class=\"band\" data-band=\"infrared\">IR</p>\n      </div>\n    </div>\n\n\n    <div class='row instruction'>\n      <div ng-switch on=\"getStep()\">\n        <div ng-switch-when=\"0\">\n          <p>Click on any radio contour or pair of jets</p>\n        </div>\n\n        <div ng-switch-when=\"1\">\n          <p>Click the associated infrared source(s)</p>\n        </div>\n\n        <div ng-switch-when=\"2\">\n          <p>Are there any more sources?</p>\n        </div>\n\n        <div ng-switch-when=\"3\">\n          <p>Great work: you helped science!</p>\n        </div>\n      </div>\n    </div>\n\n    <div class='buttons row step-{{getStep()}}'>\n      <div ng-switch on=\"getStep()\">\n        <div ng-switch-when=\"0\" class=\"col-xs-12\">\n          <button type=\"button\" class=\"btn btn-primary back\" data-ng-click=\"onCancel()\" ng-disabled=\"getContourCount()\">Cancel</button>\n          <button type=\"button\" class=\"btn btn-primary no-contours\" data-ng-click=\"onFinish()\" ng-disabled=\"!getContourCount()\">No Contours</button>\n        </div>\n        <div ng-switch-when=\"1\" class=\"col-xs-12\">\n          <button type=\"button\" class=\"btn btn-primary back\" data-ng-click=\"onCancel()\">Cancel</button>\n          <button type=\"button\" class=\"btn btn-default col-xs-offset-3 no-infrared\" data-ng-click=\"onNoCorrespondingFlux()\">No Infrared</button>\n          <button type=\"button\" class=\"btn btn-primary col-xs-offset-5 done\" data-ng-click=\"onDone()\">Done</button>\n        </div>\n        <div ng-switch-when=\"2\">\n          <button type=\"button\" class=\"btn btn-primary back\" data-ng-click=\"onCancel()\">Cancel</button>\n          <button type=\"button\" class=\"btn btn-primary next-radio\" data-ng-click=\"onNextRadio()\">Mark Another</button>\n          <button type=\"button\" class=\"btn btn-primary col-xs-offset-5 done\" data-ng-click=\"onFinish()\">Finish</button>\n        </div>\n        <div ng-switch-when=\"3\">\n          <button type=\"button\" class=\"btn btn-default\" data-ng-click=\"onFavorite($event)\">Favorite</button>\n          <button type=\"button\" class=\"btn btn-default\" data-ng-click=\"onDiscuss()\">Discuss</button>\n          <button type=\"button\" class=\"btn btn-primary col-xs-offset-7 next\" data-ng-click=\"onNext()\">Next</button>\n        </div>\n      </div>\n     </div>\n    </div>\n  </div>\n</div>";
});

;require.register("partials/home", function(exports, require, module) {
var template;

template = "<div class=\"home\">\n  <div class=\"headline\">In Search of Erupting Black Holes\n    <p class=\"call-to-action\">Help astronomers discover supermassive black holes observed by the Australia Telescope Large Area Survey.</p>\n  </div>\n  \n  <div class=\"slider\">\n    <div class=\"slide-element radio-galaxy-zoo\">\n      <p class=\"credit\">NASA, ESA, S. Baum and C. O'Dea (RIT), R. Perley and W. Cotton (NRAO/AUI/NSF), and the Hubble Heritage Team (STScI/AURA)</p>\n      <div class=\"left\">\n        <p class=\"header-title\">Search for Black Holes</p>\n        <p class=\"description\">Black holes are found at the center of most, if not all, galaxies. The bigger the galaxy, the bigger the black hole and the more sensational the effect it can have on the host galaxy. These supermassive black holes drag in nearby material, growing to billions of times the mass of our sun and occasionally producing spectacular jets of material traveling nearly as fast as the speed of light. These jets often can't be detected in visible light, but are seen using radio telescopes. Astronomers need your help to find these jets and match them to the galaxy that hosts them.</p>\n        <a class=\"blue-button\" href=\"#/classify\">Begin Hunting</a>\n      </div>\n    </div>\n  </div>\n  \n  <div class=\"content-block\">\n    <div class=\"row\">\n      <div class=\"col-xs-6\">\n        <h2>Why do astronomers need your help?</h2>\n        <p class=\"description\">Black holes cannot be directly observed, since light cannot escape from them; but we can detect them by observing the effect they have on their surroundings. There are a number of methods for probing those surroundings, but for the supermassive black holes found at the center of galaxies, any optical or infrared light is obscured by large amounts of gas and dust. Fortunately, the jets of material spewed out by these supermassive black holes can be observed in the radio wavelengths.</p>\n\n        <p class=\"description\">There is a great deal of valuable information that can be obtained from the radio images of these jets, but we need to understand the host galaxy too. For instance, observing the host galaxy allows us to determine its distance, which is critical to understanding how big and how luminous the black hole actually is.</p>\n      </div>\n      <div class=\"col-xs-6\">\n        <h2>What do astronomers hope to learn?</h2>\n        <p class=\"description\"> Astronomers have a good understanding of how small black holes (those that are several to tens of times more massive than our Sun) are formed. The picture is less clear for the supermassive black holes found in the center of galaxies. In order to better understand how these black holes form and evolve over time, astronomers need to observe many of them at different stages of their lifecycles. To do this, they need to find them first!</p>\n          <p class=\"description\">In order to better understand how supermassive black holes form, astronomers need more data to input into their models. Ideally, they need information about black holes at all stages of their lifecycle. To accomplish this, we want to identify as many black hole/jet pairs as possible and associate them with their host galaxies; with a large enough sample (from your classifications), we can pick out black holes at different stages and build a better picture of their origins.<a href=\"#/science\">More ...</a></p>\n      </div>\n    </div>\n  </div>\n  \n</div>";

module.exports = template;
});

;require.register("partials/profile", function(exports, require, module) {
var template;

template = "<div class='profile'>\n  <p>what what?! See you profile!</p>\n</div>";

module.exports = template;
});

;require.register("partials/science", function(exports, require, module) {
var template;

template = "<div class='science' data-ng-controller=\"ScienceCtrl\">\n  \n  <div class=\"content-block row\">\n    <div class=\"col-xs-6\">\n      <span class=\"content-image\">\n        <a href=\"http://www.atnf.csiro.au/people/Emil.Lenc/Gallery/\"><span class=\"image-credit\">Image Credit: Emil Lenc</span></a>\n        <img src=\"/images/science/atlas.jpg\" class=\"science-image\"/>\n        <h2>Radio Images</h2>\n      </span>\n      <p class=\"description\"> The radio data you are viewing comes from the Australia Telescope Large Area Survey (<a href=\"http://www.atnf.csiro.au/research/deep/\">ATLAS</a>), a deep radio survey of six square degrees of the sky (about 30 times the size of the full Moon). This field contains about 6000 sources. The data were taken with the Australia Telescope Compact Array (<a href=\"http://www.narrabri.atnf.csiro.au/\">ATCA</a>) in rural New South Wales. The images were taken between 2006 and 2011. With only 6000 sources, we can simultaneously have experts examine the sources by eye AND compare these to results from Radio Galaxy Zoo volunteers. We'll combine these to develop and refine our techniques for the upcoming, larger Evolutionary Map of the Universe (<a href=\"http://www.atnf.csiro.au/people/rnorris/emu/\">EMU</a>) survey.</p>\n      <p class=\"description\">EMU will be performed with the newly constructed Australian SKA Pathfinder (<a href=\"http://www.atnf.csiro.au/projects/askap/\">ASKAP</a>) telescope in Western Australia. EMU will discover about 70 million radio sources, increasing our knowledge of the radio sky by almost a factor of 30! Even more importantly, EMU will probe far more deeply than other telescopes, giving us millions of examples of types of galaxies of which only a few hundred are currently known.</p>\n    </div>\n    <div class=\"col-xs-6\">\n      <span class=\"content-image\">\n        <a href=\"http://commons.wikimedia.org/wiki/File:Spitzer_space_telescope.jpg\"><span class=\"image-credit\">Image Credit: NASA/JPL-Caltech</span></a>\n        <img src=\"/images/science/spitzer.jpg\" class=\"science-image\"/>\n        <h2>Infrared Images</h2>\n      </span>\n      <p class=\"description\">The <a href=\"http://www.jpl.nasa.gov/missions/spitzer-space-telescope/\">Spitzer Space Telescope</a> is a space-based infrared observatory launched by NASA in 2003. It studies objects ranging from our own Solar System to the distant reaches of the Universe. In the early days of the Spitzer mission, the telescope was cryogenically cooled so that its three instruments (two cameras and a spectrograph) could observe the Universe at wavelengths from 3 to 180 micrometers. Since Spitzer's helium supply was exhausted in 2009, the telescope currently operates one of its cameras in Warm Mode, continuing to image the universe at infrared wavelengths of 3.4 and 4.6 micrometers.</p>\n      <p class=\"description\">The infrared images you see in Radio Galaxy Zoo were taken as part of a program called the Spitzer Wide-Area Infrared Extragalactic Survey (<a href=\"http://swire.ipac.caltech.edu//swire/swire.html\">SWIRE</a>). These images were taken with the IRAC camera at a wavelength 3.6 micrometers. The emission from the galaxies comes from a combination of stars and from dust in the galaxy which has been heated, either by the stars themselves or by emission from a central black hole.</p>\n    </div>\n  </div>\n\n  <div class=\"content-block row\">\n    <div class=\"col-xs-6\">\n      <span class=\"content-image\">\n        <img src=\"/images/science/complex.jpg\" class=\"science-image\"/>\n        <h2>Why can’t computers do this task?</h2>\n      </span>\n      <p class=\"description\">The jets visible in the radio wavelengths and the host galaxy visible in the optical wavelengths sometimes overlap. In this case, computer programs can tell automatically that they are associated with each other. This simple case is known to astronomers as a ‘compact source’. However, the matching becomes much more complex when we start to consider sitations where there is a great deal of mixed up radio emission or very complex arrangement sof multiple sources - as in the example above.</p>   \n      <p class=\"description\">If we see three blobs of radio emission, that could either be three separate galaxies or a black hole and its two jets. It's possible for a human to tell by comparing the radio and infrared images – if the infrared shows three galaxies in a row, lining up with the respective radio spots, then it’s probably three separate galaxies. If the only infrared source is in the centre, then it’s probably a black hole and two jets. Computer programs cannot compete with the human brain for pattern recognition, especially if the radio emission is uneven or distorted.</p>\n    </div>\n    \n    <div class=\"col-xs-6\">\n      <span class=\"content-image\">\n        <img src=\"/images/science/greenpeas.jpg\" class=\"science-image\"/>\n        <h2>Serendipitous Discoveries</h2>\n      </span>\n      <p class=\"description\">A great bonus of having humans match these radio and infrared images of galaxies is the possibility of unexpected results. Computer programs only detect or measure what a human requires them too. Humans, on the other hand, are curious by nature and will question and explore unusual features that they see. Other citizen science projects built by the Zooniverse have lead to unexpected and amazing discoveries: this includes objects like <a href=\"http://en.wikipedia.org/wiki/Hanny%27s_Voorwerp\">Hanny's Voorwerp</a> and the <a href=\"http://en.wikipedia.org/wiki/Pea_galaxy\">Green Peas</a> in Galaxy Zoo, or the potentially new seaworm species discovered in Seafloor Explorer.</p>\n      <p class=\"description\">While examining the radio and infrared images, you will be often be asked if you want to ‘TALK’. This is our online discussion tool, where volunteers and the Radio Galaxy Zoo scientists can chat about things that interest them or they are unsure about. Feel free to ask about any image that peaks your curiosity. It may be easy to explain, or it might just be something completely unexpected!</p>\n    </div>\n  </div>\n\n  <div class=\"content-block row\">\n    <div class=\"col-xs-6\">\n      <span class=\"content-image\">\n        <a href=\"http://www.atnf.csiro.au/people/Emil.Lenc/Gallery/\"><span class=\"image-credit\">Image Credit: Emil Lenc</span></a>\n        <img src=\"/images/science/pictor.jpg\" class=\"science-image\"/>\n        <h2>How do supermassive black holes form?</h2>\n      </span>\n      <p class=\"description\">Astronomers have plenty of evidence that small black holes (roughly a few times the mass of our Sun) form when a large star reaches the end of its life. We're less certain about how supermassive black holes (billions of times the size of our Sun) form and grow. We think that small black holes might merge together to form larger black holes. These larger black holes then swallow surrounding material, merge again with other black holes, and so on until they become the supermassive black holes we observe at the center of massive galaxies.</p>\n      <p class=\"description\">The problem is that this process of repeated black hole merging takes many billions of years, yet we’ve found evidence for supermassive black holes less than a billion years after the Big Bang! That's not enough time for them to have grown to the sizes we observe.</p>\n      <p class=\"description\">In order to better understand how supermassive black holes form, astronomers need more data. Ideally, they need information about black holes at all stages of their lives. So we want to identify as many black hole/jet pairs as possible and associate them with their host galaxies. With a large enough sample  - from your classifications - we can pick out black holes at different stages and build a better picture of their origins.</p>\n    </div>\n    <div class=\"col-xs-6\">\n      <span class=\"content-image\">\n        <a href=\"http://www.atnf.csiro.au/people/Emil.Lenc/Gallery/\"><span class=\"image-credit\">Image Credit: Emil Lenc</span></a>\n        <img src=\"/images/science/scope.jpg\" class=\"science-image\"/>\n        <h2>Supermassive black holes and their host galaxies</h2>\n      </span>\n      <p class=\"description\">There is strong circumstantial evidence that the supermassive black holes can change the rate at which stars form in their host galaxies. It is possible that the jets from the supermassive black hole heat up and disrupt the gas within the galaxy. This might either regulate the star formation rate by expelling and heating the gas; alternatively, it might compress the gas in some parts of the galaxy and actually increase the star formation rate. Our best understanding of which of these processes dominate galaxies will be helped with bigger samples of galaxies to observe, which we hope to get from your classifications.</p>\n        <p>The ATLAS data on this site, and your clicks, will help us to better understand these objects and how they affect their host galaxies</p>\n    </div>\n  </div>\n\n</div>";

module.exports = template;
});

;require.register("partials/team", function(exports, require, module) {
var template;

template = "<div class='team' data-ng-controller=\"TeamCtrl\">\n  <h2>The Radio Galaxy Zoo Team</h2>\n  \n  <div ng-repeat=\"index in getTeamLength()\">\n    <div ng-if=\"$index % 3 == 0\" class=\"row\">\n      <div ng-repeat=\"person in team.slice($index, $index + 3)\" class=\"col-md-4\">\n        <h5>{{person.name}} <a ng-if=\"person.twitter\" href=\"http://twitter.com/{{person.twitter}}\">@{{person.twitter}}</a></h5>\n        <p>{{person.institution}}</p>\n        <p>{{person.bio}}</p>\n      </div>\n    </div>\n  </div>\n  \n</div>";

module.exports = template;
});

;require.register("services/ClassifierModel", function(exports, require, module) {
var Classification, ClassifierModel, Subject, Tutorial, TutorialSteps, User,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

User = zooniverse.models.User;

Subject = zooniverse.models.Subject;

Classification = zooniverse.models.Classification;

Tutorial = zootorial.Tutorial;

TutorialSteps = require('../content/tutorial_steps');

Subject.preload = false;

ClassifierModel = (function() {
  ClassifierModel.prototype.COMPLETE = true;

  function ClassifierModel($rootScope, $q, translateRegEx, imageDimension, fitsImageDimension, levels, contourThreshold) {
    this.onGetContours = __bind(this.onGetContours, this);
    this.onSubjectSelect = __bind(this.onSubjectSelect, this);
    this.onInitialFetch = __bind(this.onInitialFetch, this);
    this.onTutorialEnd = __bind(this.onTutorialEnd, this);
    this.startFirstTutorial = __bind(this.startFirstTutorial, this);
    this.onUserChange = __bind(this.onUserChange, this);
    this.$rootScope = $rootScope;
    this.$q = $q;
    this.translateRegEx = translateRegEx;
    this.imageDimension = imageDimension;
    this.fitsImageDimension = fitsImageDimension;
    this.levels = levels;
    this.contourThreshold = contourThreshold;
    this.showContours = true;
    this.step = 0;
    this.showSED = false;
    this.example = "compact";
    this.activeGuide = false;
    this.isDisabled = true;
    this.hasTutorial = false;
    this.initialSelect = false;
    this.infraredSource = null;
    this.radioSource = null;
    this.contours = null;
    this.currentSubject = null;
    this.nextSubject = null;
    this.classification = null;
    this.subjectContours = [];
    this.selectedContours = [];
    this.matches = [];
    this.annotations = [];
    this.contourPromise = null;
    Subject.on("fetch", this.onSubjectFetch);
    Subject.on("select", this.onSubjectSelect);
    User.on("change", this.onUserChange);
  }

  ClassifierModel.prototype.reset = function() {
    this.initialSelect = false;
    this.subjectContours.length = 0;
    d3.select("g.contours").remove();
    return d3.selectAll("g.infrared g").remove();
  };

  ClassifierModel.prototype.resetMarking = function() {
    this.selectedContours.shift();
    d3.selectAll('svg .selected').attr('class', "contour-group");
    return d3.selectAll('svg .infrared g:not(.matched)').remove();
  };

  ClassifierModel.prototype.onUserChange = function() {
    var stage1, subjects, _ref, _ref1, _ref2;
    this.reset();
    Subject.one("fetch", this.onInitialFetch);
    if ((_ref = this.tutorial) != null) {
      _ref.end();
    }
    if (User.current) {
      if (User.current.project.tutorial_done === true) {
        if ((_ref1 = Subject.instances) != null) {
          _ref1.length = 0;
        }
        Subject.fetch();
        return;
      }
    }
    if ((_ref2 = Subject.instances) != null) {
      _ref2.length = 0;
    }
    subjects = require("../content/tutorial_subject");
    stage1 = new Subject(subjects.stage1);
    this.classification = new Classification({
      stage1: stage1
    });
    Subject.fetch();
    return this.startFirstTutorial();
  };

  ClassifierModel.prototype.startFirstTutorial = function() {
    this.hasTutorial = true;
    this.tutorial = new Tutorial({
      id: 'first-tutorial',
      firstStep: 'welcome',
      steps: TutorialSteps.stage1,
      parent: document.querySelector(".classifier")
    });
    return this.tutorial.el.bind("end-tutorial", this.onTutorialEnd);
  };

  ClassifierModel.prototype.onTutorialEnd = function() {
    this.hasTutorial = false;
    return this.tutorial.end();
  };

  ClassifierModel.prototype.onInitialFetch = function() {
    var _this = this;
    if (this.hasTutorial) {
      Subject.instances.splice(1, 0, Subject.instances.pop());
      Subject.instances.splice(3, 0, Subject.instances.pop());
    }
    this.subject = Subject.instances.shift();
    this.nextSubject = Subject.instances.shift();
    this.classification = new Classification({
      subject: this.subject
    });
    return this.$rootScope.$apply(function() {
      _this.infraredSource = _this.subject.location.standard;
      return _this.radioSource = _this.subject.location.radio;
    });
  };

  ClassifierModel.prototype.onSubjectFetch = function(e, subjects) {
    return Subject.instances = _.unique(Subject.instances, false, function(d) {
      return d.id;
    });
  };

  ClassifierModel.prototype.onSubjectSelect = function(e, subject) {
    var dfd;
    this.nextSubject = subject;
    dfd = this.$q.defer();
    this.contourPromise = dfd.promise;
    this.nextInfraredSource = this.nextSubject.location.standard;
    return this.nextRadioSource = this.nextSubject.location.radio;
  };

  ClassifierModel.prototype.getSubject = function() {
    var _this = this;
    this.subject = this.nextSubject;
    this.infraredSource = this.subject.location.standard;
    this.radioSource = this.subject.location.radio;
    this.matches.length = 0;
    this.selectedContours.length = 0;
    this.annotations.length = 0;
    this.classification = new Classification({
      subject: this.subject
    });
    return this.contourPromise.then(function(subject) {
      _this.contourPromise = null;
      _this.subjectContours.shift();
      _this.drawContours(_this.subjectContours[0]);
      return Subject.next();
    });
  };

  ClassifierModel.prototype.onGetContours = function(contours, opts) {
    this.subjectContours = contours;
    if (this.initialSelect === this.COMPLETE) {
      return this.$rootScope.$apply(function() {
        return opts.dfd.resolve(opts.subject);
      });
    } else {
      this.initialSelect = true;
      return this.drawContours(this.subjectContours[0]);
    }
  };

  ClassifierModel.prototype.getContoursAsync = function(width, height, arr, opts) {
    var URL, blob, fn, mime, msg, onmessage, urlOnMessage, worker,
      _this = this;
    onmessage = function(e) {
      var conrec, contour, contours, d, data, getBBox, group, i, idx, ilb, index, iub, j, jdx, jlb, jub, k0contour, k0contours, levels, start, subcontour, subcontours, threshold, x, xd, xmax, xmin, y, yd, ymax, ymin, _i, _j, _len, _len1, _ref, _ref1, _ref2;
      importScripts("http://radio.galaxyzoo.org/beta2/workers/conrec.js");
      width = e.data.width;
      height = e.data.height;
      arr = new Float32Array(e.data.buffer);
      threshold = e.data.threshold;
      levels = e.data.levels;
      j = height;
      data = [];
      while (j--) {
        start = j * width;
        data.push(arr.subarray(start, start + width));
      }
      ilb = jlb = 0;
      iub = data.length - 1;
      jub = data[0].length - 1;
      idx = new Uint16Array(data.length);
      jdx = new Uint16Array(data[0].length);
      i = j = 0;
      while (i < idx.length) {
        idx[i] = i + 1;
        i += 1;
      }
      while (j < jdx.length) {
        jdx[j] = j + 1;
        j += 1;
      }
      conrec = new Conrec();
      conrec.contour(data, ilb, iub, jlb, jub, idx, jdx, levels.length, levels);
      contours = conrec.contourList().reverse();
      getBBox = function(arr) {
        var lastElement, x, xmax, xmin, y, ymax, ymin;
        i = arr.length - 1;
        lastElement = arr[i--];
        xmin = xmax = lastElement.x;
        ymin = ymax = lastElement.y;
        while (i--) {
          x = arr[i].x;
          y = arr[i].y;
          if (x < xmin) {
            xmin = x;
          }
          if (x > xmax) {
            xmax = x;
          }
          if (y < ymin) {
            ymin = y;
          }
          if (y > ymax) {
            ymax = y;
          }
        }
        return [[xmin, xmax], [ymin, ymax]];
      };
      k0contours = [];
      subcontours = [];
      while (contours.length) {
        contour = contours.shift();
        if (contour.k === "0") {
          k0contours.push(contour);
        } else {
          subcontours.push(contour);
        }
      }
      for (_i = 0, _len = k0contours.length; _i < _len; _i++) {
        k0contour = k0contours[_i];
        group = [];
        group.bbox = getBBox(k0contour);
        _ref = group.bbox, (_ref1 = _ref[0], xmin = _ref1[0], xmax = _ref1[1]), (_ref2 = _ref[1], ymin = _ref2[0], ymax = _ref2[1]);
        xd = xmax - xmin;
        yd = ymax - ymin;
        d = Math.sqrt(xd * xd + yd * yd);
        if (d < threshold) {
          continue;
        }
        for (index = _j = 0, _len1 = subcontours.length; _j < _len1; index = ++_j) {
          subcontour = subcontours[index];
          x = subcontour[0].x;
          y = subcontour[0].y;
          if (x > xmin && x < xmax && y > ymin && y < ymax) {
            group.push(subcontour);
          }
        }
        group.push(k0contour);
        contours.push(group);
      }
      return postMessage(contours);
    };
    fn = onmessage.toString().replace("return postMessage", "postMessage");
    fn = "onmessage = " + fn;
    mime = "application/javascript";
    blob = new Blob([fn], {
      type: mime
    });
    URL = window.URL || window.webkitURL;
    urlOnMessage = URL.createObjectURL(blob);
    worker = new Worker(urlOnMessage);
    msg = {
      width: width,
      height: height,
      buffer: arr.buffer,
      levels: this.levels,
      threshold: this.contourThreshold
    };
    worker.onmessage = function(e) {
      console.log(_.map(_.pluck(e.data, 'bbox'), function(_arg) {
        var xmax, xmin, ymax, ymin, _ref, _ref1;
        (_ref = _arg[0], xmin = _ref[0], xmax = _ref[1]), (_ref1 = _arg[1], ymin = _ref1[0], ymax = _ref1[1]);
        return {
          xmax: xmax,
          ymax: ymax,
          xmin: xmin,
          ymin: ymin
        };
      }));
      _this.subjectContours.push(e.data);
      return _this.onGetContours(opts);
    };
    return worker.postMessage(msg, [arr.buffer]);
  };

  ClassifierModel.prototype.drawContours = function(contours) {
    var contour, contourGroup, factor, g, group, index, path, pathFn, svg, _i, _j, _len, _len1,
      _this = this;
    svg = d3.select("svg.svg-contours");
    factor = this.imageDimension / this.fitsImageDimension;
    pathFn = d3.svg.line().x(function(d) {
      return factor * d.y;
    }).y(function(d) {
      return factor * d.x;
    }).interpolate("linear");
    group = svg.append("g").attr("class", "contours");
    for (index = _i = 0, _len = contours.length; _i < _len; index = ++_i) {
      contourGroup = contours[index];
      g = group.append("g").attr("class", "contour-group").attr("id", "" + index);
      for (_j = 0, _len1 = contourGroup.length; _j < _len1; _j++) {
        contour = contourGroup[_j];
        path = g.append("path").attr("d", pathFn(contour)).attr("class", "svg-contour");
      }
      g.on("click", function() {
        var classes, contourGroupId, el;
        if (_this.step !== 0) {
          return;
        }
        el = d3.select(d3.event.target.parentNode);
        classes = el.attr("class");
        contourGroupId = el.attr("id");
        el.attr("class", "contour-group selected");
        _this.$rootScope.$apply(function() {
          return _this.step = 1;
        });
        return _this.addContourGroup(contourGroupId);
      });
    }
    this.isDisabled = false;
    return setTimeout((function() {
      if (_this.hasTutorial) {
        return _this.tutorial.start();
      }
    }), 0);
  };

  ClassifierModel.prototype.toggleFavorite = function() {
    return this.classification.favorite = this.classification.favorite ? false : true;
  };

  ClassifierModel.prototype.getMatch = function() {
    var group, id, infrared, obj, path, radio, translateRegEx;
    radio = [];
    while (this.selectedContours.length) {
      id = this.selectedContours.shift();
      group = d3.select("g[id='" + id + "']");
      path = d3.select("g[id='" + id + "'] path:last-child").node();
      radio.push(path.getBBox());
      group.attr("class", "contour-group matched");
    }
    infrared = [];
    translateRegEx = this.translateRegEx;
    d3.selectAll("g.infrared g:not(.matched)").each(function() {
      var circle, match, obj, transform;
      circle = d3.select(this.children[0]);
      group = d3.select(this);
      group.classed("matched", true);
      transform = group.attr("transform");
      match = transform.match(translateRegEx);
      obj = {
        r: circle.attr("r"),
        x: match[1],
        y: match[2]
      };
      return infrared.push(obj);
    });
    obj = {
      radio: radio,
      infrared: infrared
    };
    return this.matches.push(obj);
  };

  ClassifierModel.prototype.addContourGroup = function(value) {
    return this.selectedContours.push(value);
  };

  ClassifierModel.prototype.removeContourGroup = function(value) {
    var index;
    index = this.selectedContours.indexOf(value);
    return this.selectedContours.splice(index, 1);
  };

  ClassifierModel.prototype.getClassification = function() {
    this.classification.annotate(this.matches);
    return this.classification.send();
  };

  return ClassifierModel;

})();

module.exports = ClassifierModel;
});

;
//# sourceMappingURL=app.js.map