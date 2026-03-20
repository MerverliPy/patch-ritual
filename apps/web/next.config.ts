import type { NextConfig } from 'next';

const config: NextConfig = {
  transpilePackages: ["@patch-ritual/github", "@patch-ritual/db"],
  serverExternalPackages: ["better-sqlite3"],
  webpack(webpackConfig, { isServer }) {
    if (isServer) {
      const externals = Array.isArray(webpackConfig.externals)
        ? webpackConfig.externals
        : webpackConfig.externals
          ? [webpackConfig.externals]
          : [];
      webpackConfig.externals = [...externals, "better-sqlite3"];
    }
    return webpackConfig;
  },
};

export default config;
