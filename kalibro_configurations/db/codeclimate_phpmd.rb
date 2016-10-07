codeclimate_phpmd_configuration = KalibroConfiguration.create(
  name: "CodeClimate PHPMD",
  description: "Example CodeClimate PHPMD configuration"
)

baf = HotspotMetricSnapshot.create(
  name: "CleanCode/BooleanArgumentFlag",
  code: "baf",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "A boolean flag argument is a reliable indicator for a violation of the Single Responsibility Principle (SRP). You can fix this problem by extracting the logic in the boolean flag into its own class or method."
)
MetricConfiguration.create(
  metric_snapshot_id: baf.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

ee = HotspotMetricSnapshot.create(
  name: "CleanCode/ElseExpression",
  code: "ee",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "An if expression with an else branch is never necessary. You can rewrite the conditions in a way that the else is not necessary and the code becomes simpler to read. To achieve this use early return statements. To achieve this you may need to split the code it several smaller methods. For very simple assignments you could also use the ternary operations."
)
MetricConfiguration.create(
  metric_snapshot_id: ee.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

sa = HotspotMetricSnapshot.create(
  name: "CleanCode/StaticAccess",
  code: "sa",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "Static acccess causes inexchangable dependencies to other classes and leads to hard to test code. Avoid using static access at all costs and instead inject dependencies through the constructor. The only case when static access is acceptable is when used for factory methods."
)
MetricConfiguration.create(
  metric_snapshot_id: sa.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

cccn = HotspotMetricSnapshot.create(
  name: "Controversial/CamelCaseClassName",
  code: "cccn",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "It is considered best practice to use the CamelCase notation to name classes."
)
MetricConfiguration.create(
  metric_snapshot_id: cccn.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

ccm = HotspotMetricSnapshot.create(
  name: "Controversial/CamelCaseMethodName",
  code: "ccm",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "It is considered best practice to use the camelCase notation to name methods."
)
MetricConfiguration.create(
  metric_snapshot_id: ccm.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

ccpan = HotspotMetricSnapshot.create(
  name: "Controversial/CamelCaseParameterName",
  code: "ccpan",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "It is considered best practice to use the camelCase notation to name parameters."
)
MetricConfiguration.create(
  metric_snapshot_id: ccpan.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

ccprn = HotspotMetricSnapshot.create(
  name: "Controversial/CamelCasePropertyName",
  code: "ccprn",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "It is considered best practice to use the camelCase notation to name attributes."
)
MetricConfiguration.create(
  metric_snapshot_id: ccprn.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

ccvn = HotspotMetricSnapshot.create(
  name: "Controversial/CamelCaseVariableName",
  code: "ccvn",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "It is considered best practice to use the camelCase notation to name variables."
)
MetricConfiguration.create(
  metric_snapshot_id: ccvn.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

sg = HotspotMetricSnapshot.create(
  name: "Controversial/Superglobals",
  code: "sg",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "Accessing a super-global variable directly is considered a bad practice. These variables should be encapsulated in objects that are provided by a framework, for instance."
)
MetricConfiguration.create(
  metric_snapshot_id: sg.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

cc = HotspotMetricSnapshot.create(
  name: "CyclomaticComplexity",
  code: "cc",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "Complexity is determined by the number of decision points in a method plus one for the method entry. The decision points are 'if', 'while', 'for', and 'case labels'. Generally, 1-4 is low complexity, 5-7 indicates moderate complexity, 8-10 is high complexity, and 11+ is very high complexity."
)
MetricConfiguration.create(
  metric_snapshot_id: cc.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

cbo = HotspotMetricSnapshot.create(
  name: "Design/CouplingBetweenObjects",
  code: "cbo",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "A class with too many dependencies has negative impacts on several quality aspects of a class. This includes quality criteria like stability, maintainability and understandability"
)
MetricConfiguration.create(
  metric_snapshot_id: cbo.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

doi = HotspotMetricSnapshot.create(
  name: "Design/DepthOfInheritance",
  code: "doi",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "A class with many parents is an indicator for an unbalanced and wrong class hierarchy. You should consider to refactor this class hierarchy."
)
MetricConfiguration.create(
  metric_snapshot_id: doi.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

eex = HotspotMetricSnapshot.create(
  name: "Design/EvalExpression",
  code: "eex",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "An eval-expression is untestable, a security risk and bad practice. Therefore it should be avoided. Consider to replace the eval-expression with regular code."
)
MetricConfiguration.create(
  metric_snapshot_id: eex.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

exe = HotspotMetricSnapshot.create(
  name: "Design/ExitExpression",
  code: "exe",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "An exit-expression within regular code is untestable and therefore it should be avoided. Consider to move the exit-expression into some kind of startup script where an error/exception code is returned to the calling environment."
)
MetricConfiguration.create(
  metric_snapshot_id: exe.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

gs = HotspotMetricSnapshot.create(
  name: "Design/GotoStatement",
  code: "gs",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "Goto makes code harder to read and it is nearly impossible to understand the control flow of an application that uses this language construct. Therefore it should be avoided. Consider to replace Goto with regular control structures and separate methods/function, which are easier to read."
)
MetricConfiguration.create(
  metric_snapshot_id: gs.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

lc = HotspotMetricSnapshot.create(
  name: "Design/LongClass",
  code: "lc",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "Long Class files are indications that the class may be trying to do too much. Try to break it down, and reduce the size to something manageable."
)
MetricConfiguration.create(
  metric_snapshot_id: lc.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

lm = HotspotMetricSnapshot.create(
  name: "Design/LongMethod",
  code: "lm",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "Violations of this rule usually indicate that the method is doing too much. Try to reduce the method size by creating helper methods and removing any copy/pasted code."
)
MetricConfiguration.create(
  metric_snapshot_id: lm.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

lpl = HotspotMetricSnapshot.create(
  name: "Design/LongParameterList",
  code: "lpl",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "Long parameter lists can indicate that a new object should be created to wrap the numerous parameters. Basically, try to group the parameters together."
)
MetricConfiguration.create(
  metric_snapshot_id: lpl.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

npath = HotspotMetricSnapshot.create(
  name: "Design/NpathComplexity",
  code: "npath",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "The NPath complexity of a method is the number of acyclic execution paths through that method. A threshold of 200 is generally considered the point where measures should be taken to reduce complexity."
)
MetricConfiguration.create(
  metric_snapshot_id: npath.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

noc = HotspotMetricSnapshot.create(
  name: "Design/NumberOfChildren",
  code: "noc",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "A class with an excessive number of children is an indicator for an unbalanced class hierarchy. You should consider to refactor this class hierarchy."
)
MetricConfiguration.create(
  metric_snapshot_id: noc.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

tmf = HotspotMetricSnapshot.create(
  name: "Design/TooManyFields",
  code: "tmf",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "Classes that have too many fields could be redesigned to have fewer fields, possibly through some nested object grouping of some of the information. For example, a class with city/state/zip fields could instead have one Address field."
)
MetricConfiguration.create(
  metric_snapshot_id: tmf.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

tmm = HotspotMetricSnapshot.create(
  name: "Design/TooManyMethods",
  code: "tmm",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "A class with too many methods is probably a good suspect for refactoring, in order to reduce its complexity and find a way to have more fine grained objects."
)
MetricConfiguration.create(
  metric_snapshot_id: tmm.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

tmpm = HotspotMetricSnapshot.create(
  name: "Design/TooManyPublicMethods",
  code: "tmpm",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "A large number of public methods and attributes declared in a class can indicate the class may need to be broken up as increased effort will be required to thoroughly test it."
)
MetricConfiguration.create(
  metric_snapshot_id: tmpm.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

wmc = HotspotMetricSnapshot.create(
  name: "Design/WeightedMethodCount",
  code: "wmc",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "The Weighted Method Count (WMC) of a class is a good indicator of how much time and effort is required to modify and maintain this class. The WMC metric is defined as the sum of complexities of all methods declared in a class. A large number of methods also means that this class has a greater potential impact on derived classes."
)
MetricConfiguration.create(
  metric_snapshot_id: wmc.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

epc = HotspotMetricSnapshot.create(
  name: "ExcessivePublicCount",
  code: "epc",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "A large number of public methods and attributes declared in a class can indicate the class may need to be broken up as increased effort will be required to thoroughly test it."
)
MetricConfiguration.create(
  metric_snapshot_id: epc.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

bgmn = HotspotMetricSnapshot.create(
  name: "Naming/BooleanGetMethodName",
  code: "bgmn",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "Looks for methods named 'getX()' with 'boolean' as the return type. The convention is to name these methods 'isX()' or 'hasX()'."
)
MetricConfiguration.create(
  metric_snapshot_id: bgmn.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

cnc = HotspotMetricSnapshot.create(
  name: "Naming/ConstantNamingConventions",
  code: "cnc",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "Class/Interface constant nanmes should always be defined in uppercase."
)
MetricConfiguration.create(
  metric_snapshot_id: cnc.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

cwnaec = HotspotMetricSnapshot.create(
  name: "Naming/ConstructorWithNameAsEnclosingClass",
  code: "cwnaec",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "A constructor method should not have the same name as the enclosing class, consider to use the PHP 5 __construct method."
)
MetricConfiguration.create(
  metric_snapshot_id: cwnaec.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

lv = HotspotMetricSnapshot.create(
  name: "Naming/LongVariable",
  code: "lv",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "Detects when a field, formal or local variable is declared with a long name."
)
MetricConfiguration.create(
  metric_snapshot_id: lv.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

smn = HotspotMetricSnapshot.create(
  name: "Naming/ShortMethodName",
  code: "smn",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "Detects when very short method names are used."
)
MetricConfiguration.create(
  metric_snapshot_id: smn.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

sv = HotspotMetricSnapshot.create(
  name: "Naming/ShortVariable",
  code: "sv",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "Detects when a field, local, or parameter has a very short name."
)
MetricConfiguration.create(
  metric_snapshot_id: sv.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

ufp = HotspotMetricSnapshot.create(
  name: "UnusedFormalParameter",
  code: "ufp",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "Avoid passing parameters to methods or constructors and then not using those parameters."
)
MetricConfiguration.create(
  metric_snapshot_id: ufp.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

ulv = HotspotMetricSnapshot.create(
  name: "UnusedLocalVariable",
  code: "ulv",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "Detects when a local variable is declared and/or assigned, but not used."
)
MetricConfiguration.create(
  metric_snapshot_id: ulv.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

upf = HotspotMetricSnapshot.create(
  name: "UnusedPrivateField",
  code: "upf",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "Detects when a private field is declared and/or assigned a value, but not used."
)
MetricConfiguration.create(
  metric_snapshot_id: upf.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

upm = HotspotMetricSnapshot.create(
  name: "UnusedPrivateMethod",
  code: "upm",
  metric_collector_name: "CodeClimate PHPMD",
  scope: {'type' => "SOFTWARE"},
  description: "Unused Private Method detects when a private method is declared but is unused."
)
MetricConfiguration.create(
  metric_snapshot_id: upm.id, kalibro_configuration_id: codeclimate_phpmd_configuration.id
)

