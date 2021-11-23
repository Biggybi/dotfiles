local lspconfig = require'lspconfig'
lspconfig.ccls.setup {
  init_options = {
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math"} ;
    };

    filetypes = { "c", "cpp", "objc", "objcpp" },
    rootPatterns = { ".ccls", ".git/compile_commands.json", ".vim/", ".git/", ".hg/" };
    highlight = {
      lsRanges = true;
    };
  }
}
