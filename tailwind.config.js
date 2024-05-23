/** @type {import('tailwindcss').Config} */

const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
    darkMode: 'class',
    content: [
        "./src/**/*.{html,js}",
        "./resources/**/*.blade.php",
        "./resources/**/*.js",
    ],
    theme: {
        fontFamily: {
            satoshi: ['Satoshi', 'sans-serif'],
            roboto: ['Roboto', 'sans-serif'],
            poppins: ['Poppins', 'sans-serif'],
        },
        screens: {
            '2xsm': '375px',
            xsm: '425px',
            '3xl': '2000px',
            ...defaultTheme.screens,
        },
        
    },
    plugins: [],
}
