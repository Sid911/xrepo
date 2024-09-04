package("argparse")
  set_kind("library", {headeronly = true})
  set_homepage("https://github.com/morrisfranken/argparse")
  set_description("Modern Argument Parser for C++17")
  set_license("Apache-2.0")

  -- Master branch
  add_urls("https://github.com/morrisfranken/argparse.git")

  on_install(function (package)
    os.cp("include", package:installdir())
  end)

  on_test(function (package)
    assert(package:check_cxxsnippets({test = [[
        #include "argparse/argparse.hpp"
        struct MyArgs : public argparse::Args {
            std::string &anonymous = arg("an anonymous positional string argument");
            std::string &src_path  = arg("src_path", "a positional string argument");
            int &k                 = kwarg("k", "A keyworded integer value");
            float &alpha           = kwarg("a,alpha", "An optional float value").set_default(0.5f);
            bool &verbose          = flag("v,verbose", "A flag to toggle verbose");
        };
        int main(int argc, char* argv[]) {
            auto args = argparse::parse<MyArgs>(argc, argv);

            if (args.verbose)
                args.print();      // prints all variables

            return 0;
        }
      ]]}, {configs = {languages = "c++17"}})
    end)

