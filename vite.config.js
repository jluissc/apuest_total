import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';

export default defineConfig({
    plugins: [
        laravel({
            input: [
                'resources/js/app.js',
                'resources/js/auth/password/reset.js',
                'resources/js/auth/password/change.js',
                'resources/js/comercial/dynamic-tables/main.js',
                'resources/css/app.css',
                'resources/js/comercial/dashboards/per-period.js',
                'resources/js/comercial/prospection/form/main.js',
                'resources/js/comercial/prospection/tracking/main.js',
                'resources/js/rrhh/personal-list/main.js',
                'resources/js/rrhh/proposal-cese/main.js',
                'resources/js/comercial/personal-list/main.js',
                'resources/js/comercial/proposal-cese/main.js'
            ],
            refresh: true,
        }),
    ],
});
