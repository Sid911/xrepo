package("flux")
    set_kind("library", {headeronly = true})
    set_homepage("https://tristanbrindle.com/flux/")
    set_description("A C++20 library for sequence-orientated programming")
    set_license("BSL-1.0")

    add_urls("https://github.com/tcbrindle/flux/archive/v$(version).zip")
    add_versions("0.4.0", "d17c656934688e085197eb6bd576a2e468d2b513c4f3be60121b8863c0830e13")

    on_install(function (package)
        os.cp("include", package:installdir())
    end)

    on_test(function (package)
        assert(package:check_cxxsnippets({test = [[
            #include <flux.hpp>
            void test() {
                constexpr auto result = flux::from(std::array{1, 2, 3, 4, 5})
                         .filter(flux::pred::even)
                         .map([](int i) { return i * 2; })
                         .sum();
                static_assert(result == 12);
            }
        ]]}, {configs = {languages = "c++20"}}))
    end)
