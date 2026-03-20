import type { NextConfig } from 'next';

const config: NextConfig = {
  transpilePackages: ["@patch-ritual/github", "@patch-ritual/db"],
};

export default config;
