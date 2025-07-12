// ecosystem.config.cjs
module.exports = {
  apps: [
    {
      name: "my-remix-app",
      cwd: "/home/deployer/Development/projects/nf010-nifl-website-ui",

      // Use npm start so it runs "node build/index.js"
      script: "npm",
      args: "start",

      env_production: {
        NODE_ENV: "production",
        PORT: 3000
      },

      autorestart: true
    }
  ]
};
;
