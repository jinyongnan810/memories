import globals from 'globals';
import pluginJs from '@eslint/js';
import tseslint from 'typescript-eslint';
// import { flatRules as prettierRules } from "eslint-config-prettier";
import pkg from 'eslint-config-prettier';
const { flatRules: prettierRules } = pkg;
import pluginPrettier from 'eslint-plugin-prettier';

export default [
  { files: ['**/*.ts'] },
  { languageOptions: { globals: globals.node } },
  { ignores: ['node_modules', 'dist'] },
  pluginJs.configs.recommended,
  ...tseslint.configs.recommended,
  {
    plugins: {
      prettier: pluginPrettier,
    },
    rules: {
      ...prettierRules,
      // Your custom ESLint rules
      'prettier/prettier': 'error', // Make Prettier errors show in ESLint
      'comma-dangle': ['error', 'always-multiline'],
    },
  },
];
