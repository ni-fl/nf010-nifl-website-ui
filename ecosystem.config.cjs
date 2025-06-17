module.exports = {
  apps: [
    {
      name: "my-remix-app",
      cwd: "/home/deployer/my-remix-app",
      script: "node",
      args: "build/index.js",
      autorestart: true,
      env: {
        NODE_ENV: "production",
        PORT: 3000
      },
    }
  ]
};
