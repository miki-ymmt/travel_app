module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        'icicle': '#E2E8E4',
        'cerulean': '#006C84',
        'blue-topaz': '#6EB5C0',
        'sunrise': '#FFCCBB',
      },
      fontfamily: {
        'caveat': ['Caveat', 'cursive'],
        'zen': ['Zen Maru Gothic', 'serif'],
      },
    },
  },
  plugins: [require("daisyui")],
    daisyui: {
      themes: ["light", "dark", "pastel"]
    },
}
