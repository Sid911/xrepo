package("flux")
    set_kind("library", {headeronly = true})
    set_homepage("https://tristanbrindle.com/flux/")
    set_description("A C++20 library for sequence-orientated programming")
    set_license("BSL-1.0")

    add_urls("https://github.com/vimpunk/mio.git")
    add_configs("single_header", {description="Include single header instead file",default=false, type="boolean"})

    on_install(function (package)
      if package:config("single_header") then
        os.cp("single_include", package:installdir())
      else
        os.cp("include", package:installdir())
      end
    end)

    on_test(function (package)
      if package:config("single_header") then
        assert(package:check_cxxsnippets({test = [[
          #include <mio/mio.hpp>
        ]]}, {configs = {languages = "c++11"}}))
      else
        assert(package:check_cxxsnippets({test = [[
          #include <mio/mmap.hpp>
        ]]}, {configs = {languages = "c++11"}}))
      end
    end)

