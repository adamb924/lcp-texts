module.exports = function(grunt) {
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-postcss');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-htmlmin');
grunt.loadNpmTasks('grunt-html');

  // Default task(s).
  grunt.registerTask('default', ['clean','jshint','copy','uglify','postcss','htmllint','htmlmin']);

  require('load-grunt-tasks')(grunt);

  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
	clean: ["build"],
	  jshint: {
		all: ['Gruntfile.js', 'script.js', 'script-text.js' ]
	  },
	copy: {
	  main: {
		files: [
		  {expand: true, src: ['*.gif'], dest: 'build/', filter: 'isFile'},
		],
	  },
	},
	postcss: {
		options: {
		  map: false,
		  processors: [
			require('pixrem')(), // add fallbacks for rem units
			require('autoprefixer')(), // add vendor prefixes
			require('cssnano')() // minify the result
		  ]
		},
	dist: {
		files: {
			'build/style.css': 'style.css'
		}
	}
  },
	uglify: {
      build: {
		files: {
			'build/script.js': 'script.js',
			'build/script-text.js': 'script-text.js',
		}
      }
    },
  htmllint: {
	  all: ["*.html"]
  },
  htmlmin: {
    dist: {
		options: {
        removeComments: true,
        collapseWhitespace: true
      },
      files: {
		'build/AfghanPresident.html' : 'AfghanPresident.html',
		'build/AfghanPresident2.html' : 'AfghanPresident2.html',
		'build/Age.html' : 'Age.html',
		'build/Bono.html' : 'Bono.html',
		'build/CaspianSea.html' : 'CaspianSea.html',
		'build/Ebola.html' : 'Ebola.html',
		'build/GeorgeClooney.html' : 'GeorgeClooney.html',
		'build/index.html' : 'index.html',
		'build/KabulNewspapers.html' : 'KabulNewspapers.html',
		'build/Ministers.html' : 'Ministers.html',
		'build/Spaceship.html' : 'Spaceship.html',
		'build/SuicideAttack.html' : 'SuicideAttack.html',
		'build/TalibanAnnouncement.html' : 'TalibanAnnouncement.html',
		'build/Turkey.html' : 'Turkey.html',
      }
    },
  },
  
  });
};