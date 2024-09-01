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
      animation: {
        "puff-in-center": "puff-in-center 4.0s ease    ",
        'nudge-mouse': 'nudgeMouse 5s ease-out infinite',
        'nudge-text': 'nudgeText 5s ease-out infinite',
        'color-slide': 'colorSlide 5s linear infinite',
        'track-ball-slide': 'trackBallSlide 5s linear infinite',
        'color-text': 'colorText 10s linear infinite',
      },
      keyframes: {
        "puff-in-center": {
            "0%": {
                transform: "scale(2)",
                filter: "blur(2px)",
                opacity: "0"
            },
            to: {
                transform: "scale(1)",
                filter: "blur(0)",
                opacity: "1"
            }
        },
        colorSlide: {
          "0%": { backgroundPosition: "0% 100%" },
          "20%": { backgroundPosition: "0% 0%" },
          "21%": { backgroundColor: "#4e5559" },
          "29.99%": { backgroundColor: "#ffffff", backgroundPosition: "0% 0%" },
          "30%": { backgroundColor: "#4e5559", backgroundPosition: "0% 100%" },
          "50%": { backgroundPosition: "0% 0%" },
          "51%": { backgroundColor: "#4e5559" },
          "59%": { backgroundColor: "#ffffff", backgroundPosition: "0% 0%" },
          "60%": { backgroundColor: "#4e5559", backgroundPosition: "0% 100%" },
          "80%": { backgroundPosition: "0% 0%" },
          "81%": { backgroundColor: "#4e5559" },
          "90%, 100%": { backgroundColor: "#ffffff" },
        },
        colorText: {
          "21%": { color: "#4e5559" },
          "30%": { color: "#ffffff" },
          "51%": { color: "#4e5559" },
          "60%": { color: "#ffffff" },
          "81%": { color: "#4e5559" },
          "90%": { color: "#ffffff" },
        },
        trackBallSlide: {
          "0%": { opacity: "1", transform: "scale(1) translateY(-20px)" },
          "6%": { opacity: "1", transform: "scale(0.9) translateY(5px)" },
          "14%": { opacity: "0", transform: "scale(0.4) translateY(40px)" },
          "15%, 19%": { opacity: "0", transform: "scale(0.4) translateY(-20px)" },
          "28%, 29.99%": { opacity: "1", transform: "scale(1) translateY(-20px)" },
          "30%": { opacity: "1", transform: "scale(1) translateY(-20px)" },
          "36%": { opacity: "1", transform: "scale(0.9) translateY(5px)" },
          "44%": { opacity: "0", transform: "scale(0.4) translateY(40px)" },
          "45%, 49%": { opacity: "0", transform: "scale(0.4) translateY(-20px)" },
          "58%, 59.99%": { opacity: "1", transform: "scale(1) translateY(-20px)" },
          "60%": { opacity: "1", transform: "scale(0.9) translateY(-20px)" },
          "66%": { opacity: "1", transform: "scale(0.9) translateY(5px)" },
          "74%": { opacity: "0", transform: "scale(0.4) translateY(40px)" },
          "75%, 79%": { opacity: "0", transform: "scale(0.4) translateY(-20px)" },
          "88%, 100%": { opacity: "1", transform: "scale(1) translateY(-20px)" },
        },
        nudgeMouse: {
          "0%": { transform: "translateY(0)" },
          "20%": { transform: "translateY(8px)" },
          "30%": { transform: "translateY(0)" },
          "50%": { transform: "translateY(8px)" },
          "60%": { transform: "translateY(0)" },
          "80%": { transform: "translateY(8px)" },
          "90%": { transform: "translateY(0)" },
        },
        nudgeText: {
          "0%": { transform: "translateY(0)" },
          "20%": { transform: "translateY(2px)" },
          "30%": { transform: "translateY(0)" },
          "50%": { transform: "translateY(2px)" },
          "60%": { transform: "translateY(0)" },
          "80%": { transform: "translateY(2px)" },
          "90%": { transform: "translateY(0)" },
        },
      },
    },
  },
  plugins: [require("daisyui")],
    daisyui: {
      themes: ["light", "dark", "pastel"]
    },
}
