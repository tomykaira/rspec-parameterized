# Change Log
## Unreleased
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v1.0.2...master)

## [v1.0.2](https://github.com/tomykaira/rspec-parameterized/tree/v1.0.1) (2024-04-28)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v1.0.1...v1.0.2)

- Hard-code the license name
  - https://github.com/tomykaira/rspec-parameterized/pull/88

## [v1.0.1](https://github.com/tomykaira/rspec-parameterized/tree/v1.0.1) (2024-04-28)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v1.0.0...v1.0.1)

- Reference LICENSE file in .gemspec
  - https://github.com/tomykaira/rspec-parameterized/pull/87

## [v1.0.0](https://github.com/tomykaira/rspec-parameterized/tree/v1.0.0) (2022-12-31)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.5.3...v1.0.0)

- Split gems
  - https://github.com/tomykaira/rspec-parameterized/issues/82
  - https://github.com/tomykaira/rspec-parameterized/pull/83

See also

- [Upgrading Guide](UPGRADING.md#v10)
- https://github.com/rspec-parameterized/rspec-parameterized-table_syntax/blob/main/CHANGELOG.md#100---2022-12-31
- https://github.com/rspec-parameterized/rspec-parameterized-core/blob/main/CHANGELOG.md#100---2022-12-31

## [v0.5.3](https://github.com/tomykaira/rspec-parameterized/tree/v0.5.3) (2022-12-29)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.5.2...v0.5.3)

- Fix uninitialized instance variable warning
  - https://github.com/tomykaira/rspec-parameterized/pull/78
- Support Ruby 3.2
  - https://github.com/tomykaira/rspec-parameterized/pull/81
  - https://github.com/tomykaira/rspec-parameterized/issues/80

## [v0.5.2](https://github.com/tomykaira/rspec-parameterized/tree/v0.5.2) (2022-06-24)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.5.1...v0.5.2)

- Made MFA mandatory for gem releases
  - https://github.com/tomykaira/rspec-parameterized/pull/79

## [v0.5.1](https://github.com/tomykaira/rspec-parameterized/tree/v0.5.1) (2022-01-04)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.5.0...v0.5.1)

- Changes to apply method calls recursively when parameter is Array or Hash.
  - https://github.com/tomykaira/rspec-parameterized/pull/75

## [v0.5.0](https://github.com/tomykaira/rspec-parameterized/tree/v0.5.0) (2021-06-29)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.4.2...v0.5.0)

- Support new parameter type: ref and lazy
  - https://github.com/tomykaira/rspec-parameterized/pull/62
  - https://github.com/tomykaira/rspec-parameterized/pull/65

## [v0.4.2](https://github.com/tomykaira/rspec-parameterized/tree/v0.4.2) (2019-04-26)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.4.1...v0.4.2)

- Support jruby
  - https://github.com/tomykaira/rspec-parameterized/pull/54
  - https://github.com/tomykaira/rspec-parameterized/issues/49

## [v0.4.1](https://github.com/tomykaira/rspec-parameterized/tree/v0.4.1) (2018-12-06)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.4.0...v0.4.1)

- Replace binding_of_caller with binding_ninja
  - https://github.com/tomykaira/rspec-parameterized/pull/44
  - https://github.com/tomykaira/rspec-parameterized/issues/48

## [v0.4.0](https://github.com/tomykaira/rspec-parameterized/tree/v0.4.0) (2017-06-13)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.3.2...v0.4.0)

**Merged pull requests:**

- Verbose test syntax [\#42](https://github.com/tomykaira/rspec-parameterized/pull/42) ([aliaksandr-martsinovich](https://github.com/aliaksandr-martsinovich))
- Customizable description [\#41](https://github.com/tomykaira/rspec-parameterized/pull/41) ([aliaksandr-martsinovich](https://github.com/aliaksandr-martsinovich))

## [v0.3.2](https://github.com/tomykaira/rspec-parameterized/tree/v0.3.2) (2016-12-26)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.3.1...v0.3.2)

**Merged pull requests:**

- Fix deprecation warning on ruby 2.4.0 [\#40](https://github.com/tomykaira/rspec-parameterized/pull/40) ([sue445](https://github.com/sue445))
- Add release note for v0.3.1 [\#39](https://github.com/tomykaira/rspec-parameterized/pull/39) ([sue445](https://github.com/sue445))
- Add rubygems version badge [\#38](https://github.com/tomykaira/rspec-parameterized/pull/38) ([sue445](https://github.com/sue445))

## [v0.3.1](https://github.com/tomykaira/rspec-parameterized/tree/v0.3.1) (2016-08-17)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.3.0...v0.3.1)

**Closed issues:**

- Support "||" syntax [\#34](https://github.com/tomykaira/rspec-parameterized/issues/34)

**Merged pull requests:**

- Set the caller of `.with\_them` to metadata of ExampleGroup [\#37](https://github.com/tomykaira/rspec-parameterized/pull/37) ([nalabjp](https://github.com/nalabjp))
- Add homepage url in gemspec [\#33](https://github.com/tomykaira/rspec-parameterized/pull/33) ([sue445](https://github.com/sue445))
- Tweak travis setting [\#32](https://github.com/tomykaira/rspec-parameterized/pull/32) ([sue445](https://github.com/sue445))
- Generate CHANGELOG [\#31](https://github.com/tomykaira/rspec-parameterized/pull/31) ([sue445](https://github.com/sue445))

## [v0.3.0](https://github.com/tomykaira/rspec-parameterized/tree/v0.3.0) (2016-02-22)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.2.0...v0.3.0)

**Closed issues:**

- Usage of variables in testcase name [\#27](https://github.com/tomykaira/rspec-parameterized/issues/27)
- Remove `where\_table` method, when release next version [\#24](https://github.com/tomykaira/rspec-parameterized/issues/24)
- Release v0.2.0 [\#23](https://github.com/tomykaira/rspec-parameterized/issues/23)
- UTF-8 is converted to ASCII8BIT through sourcify [\#5](https://github.com/tomykaira/rspec-parameterized/issues/5)
- where\_table does not work with proc [\#4](https://github.com/tomykaira/rspec-parameterized/issues/4)

**Merged pull requests:**

- Enable to browse parameter values in with\_them block [\#30](https://github.com/tomykaira/rspec-parameterized/pull/30) ([joker1007](https://github.com/joker1007))
- Remove unnecessary methods [\#29](https://github.com/tomykaira/rspec-parameterized/pull/29) ([joker1007](https://github.com/joker1007))
- Remove `where\_table` [\#28](https://github.com/tomykaira/rspec-parameterized/pull/28) ([joker1007](https://github.com/joker1007))

## [v0.2.0](https://github.com/tomykaira/rspec-parameterized/tree/v0.2.0) (2015-09-17)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.1.3...v0.2.0)

**Merged pull requests:**

- allow hash arguments [\#22](https://github.com/tomykaira/rspec-parameterized/pull/22) ([takkanm](https://github.com/takkanm))
- Update README to use expect syntax. [\#21](https://github.com/tomykaira/rspec-parameterized/pull/21) ([JunichiIto](https://github.com/JunichiIto))

## [v0.1.3](https://github.com/tomykaira/rspec-parameterized/tree/v0.1.3) (2015-02-13)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.1.2...v0.1.3)

**Closed issues:**

- rspec-parameterized-0.1.1.gem is broken [\#18](https://github.com/tomykaira/rspec-parameterized/issues/18)

**Merged pull requests:**

- Accept nil/boolean for 1st column [\#20](https://github.com/tomykaira/rspec-parameterized/pull/20) ([ryonext](https://github.com/ryonext))
- Update travis config [\#19](https://github.com/tomykaira/rspec-parameterized/pull/19) ([joker1007](https://github.com/joker1007))

## [v0.1.2](https://github.com/tomykaira/rspec-parameterized/tree/v0.1.2) (2014-09-04)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.1.1...v0.1.2)

**Merged pull requests:**

- Remove trailing '\>' character from TableSyntax [\#17](https://github.com/tomykaira/rspec-parameterized/pull/17) ([joker1007](https://github.com/joker1007))
- \[Suggest\] Where table syntax by Refinement [\#16](https://github.com/tomykaira/rspec-parameterized/pull/16) ([joker1007](https://github.com/joker1007))

## [v0.1.1](https://github.com/tomykaira/rspec-parameterized/tree/v0.1.1) (2014-05-16)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.1.0...v0.1.1)

**Merged pull requests:**

- Support RSpec3 [\#15](https://github.com/tomykaira/rspec-parameterized/pull/15) ([joker1007](https://github.com/joker1007))

## [v0.1.0](https://github.com/tomykaira/rspec-parameterized/tree/v0.1.0) (2014-04-06)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.0.9...v0.1.0)

**Merged pull requests:**

- Fix AST manipulation, for remove sourcify [\#14](https://github.com/tomykaira/rspec-parameterized/pull/14) ([joker1007](https://github.com/joker1007))
- Clear "already initialized constant Regexp::ENC\_XXX" warnings. [\#13](https://github.com/tomykaira/rspec-parameterized/pull/13) ([saturday06](https://github.com/saturday06))

## [v0.0.9](https://github.com/tomykaira/rspec-parameterized/tree/v0.0.9) (2013-07-29)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.0.8...v0.0.9)

**Merged pull requests:**

- Update rspec to v2.14 [\#12](https://github.com/tomykaira/rspec-parameterized/pull/12) ([joker1007](https://github.com/joker1007))

## [v0.0.8](https://github.com/tomykaira/rspec-parameterized/tree/v0.0.8) (2013-05-16)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.0.7...v0.0.8)

**Closed issues:**

- Please support rspec-rails 2.12 [\#9](https://github.com/tomykaira/rspec-parameterized/issues/9)

**Merged pull requests:**

- rspec: 2.12.0 -\> 2.13.0 [\#10](https://github.com/tomykaira/rspec-parameterized/pull/10) ([sue445](https://github.com/sue445))

## [v0.0.7](https://github.com/tomykaira/rspec-parameterized/tree/v0.0.7) (2012-11-13)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.0.6...v0.0.7)

## [v0.0.6](https://github.com/tomykaira/rspec-parameterized/tree/v0.0.6) (2012-09-24)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.0.5...v0.0.6)

**Merged pull requests:**

- Fix where scope, in order to use let method and matcher in where blocks [\#7](https://github.com/tomykaira/rspec-parameterized/pull/7) ([joker1007](https://github.com/joker1007))

## [v0.0.5](https://github.com/tomykaira/rspec-parameterized/tree/v0.0.5) (2012-08-22)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.0.4...v0.0.5)

## [v0.0.4](https://github.com/tomykaira/rspec-parameterized/tree/v0.0.4) (2012-08-20)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.0.3...v0.0.4)

**Merged pull requests:**

- Update to rspec 2.11.0 [\#6](https://github.com/tomykaira/rspec-parameterized/pull/6) ([mfolnovic](https://github.com/mfolnovic))

## [v0.0.3](https://github.com/tomykaira/rspec-parameterized/tree/v0.0.3) (2012-05-24)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.0.2...v0.0.3)

**Closed issues:**

- Where cannot be after with\_them [\#1](https://github.com/tomykaira/rspec-parameterized/issues/1)

**Merged pull requests:**

- fix params.inspect for document format. use Hash and Proc soucify. [\#3](https://github.com/tomykaira/rspec-parameterized/pull/3) ([joker1007](https://github.com/joker1007))
- fix where\_table method comment. method name was "where". [\#2](https://github.com/tomykaira/rspec-parameterized/pull/2) ([joker1007](https://github.com/joker1007))

## [v0.0.2](https://github.com/tomykaira/rspec-parameterized/tree/v0.0.2) (2012-05-22)
[Full Changelog](https://github.com/tomykaira/rspec-parameterized/compare/v0.0.1...v0.0.2)

## [v0.0.1](https://github.com/tomykaira/rspec-parameterized/tree/v0.0.1) (2012-05-20)


\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*
