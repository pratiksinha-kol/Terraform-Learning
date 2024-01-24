## Expressions

https://developer.hashicorp.com/terraform/language/expressions 

Expressions refer to or compute values within a configuration. The simplest expressions are just literal values, like `"hello"` or `5`, but the Terraform language also allows more complex expressions such as references to data exported by resources, arithmetic, conditional evaluation, and a number of built-in functions.

Expressions can be used in a number of places in the Terraform language, but some contexts limit which expression constructs are allowed, such as requiring a literal value of a particular type or forbidding [references to resource attributes](https://developer.hashicorp.com/terraform/language/expressions/references#references-to-resource-attributes). Each language feature's documentation describes any restrictions it places on expressions.

## 

The other pages in this section describe the features of Terraform's expression syntax.

- **[Types and Values](https://developer.hashicorp.com/terraform/language/expressions/types)** documents the data types that Terraform expressions can resolve to, and the literal syntaxes for values of those types.

- **[Strings and Templates](https://developer.hashicorp.com/terraform/language/expressions/strings)** documents the syntaxes for string literals, including interpolation sequences and template directives.

- **[References to Values](https://developer.hashicorp.com/terraform/language/expressions/references)** documents how to refer to named values like variables and resource attributes.

- **[Operators](https://developer.hashicorp.com/terraform/language/expressions/operators)** documents the arithmetic, comparison, and logical operators.

- **[Function Calls](https://developer.hashicorp.com/terraform/language/expressions/function-calls)** documents the syntax for calling Terraform's built-in functions.

- **[Conditional Expressions](https://developer.hashicorp.com/terraform/language/expressions/conditionals)** documents the `<CONDITION> ? <TRUE VAL> : <FALSE VAL>` expression, which chooses between two values based on a bool condition.

- **[For Expressions](https://developer.hashicorp.com/terraform/language/expressions/for)** documents expressions like [for s in var.list : upper(s)], which can transform a complex type value into another complex type value.

- **[Splat Expressions](https://developer.hashicorp.com/terraform/language/expressions/splat)** documents expressions like var.list[*].id, which can extract simpler collections from more complicated expressions.

- **[Dynamic Blocks](https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks)** documents a way to create multiple repeatable nested blocks within a resource or other construct.

- **[Type Constraints](https://developer.hashicorp.com/terraform/language/expressions/type-constraints)** documents the syntax for referring to a type, rather than a value of that type. Input variables expect this syntax in their type argument.

- **[Version Constraints](https://developer.hashicorp.com/terraform/language/expressions/version-constraints)** documents the syntax of special strings that define a set of allowed software versions. Terraform uses version constraints in several places.

### Types and Values

https://developer.hashicorp.com/terraform/language/expressions/types

### Strings and Templates

https://developer.hashicorp.com/terraform/language/expressions/strings 

String literals are the most complex kind of literal expression in Terraform, and also the most commonly used.

Terraform supports both a quoted syntax and a "heredoc" syntax for strings. Both of these syntaxes support template sequences for interpolating values and manipulating text.

#### Interpolation

A `${ ... }` sequence is an interpolation, which evaluates the expression given between the markers, converts the result to a string if necessary, and then inserts it into the final string:

```
"Hello, ${var.name}!"
```

In the above example, the named object `var.name` is accessed and its value inserted into the string, producing a result like "Hello, Juan!".

#### Directives

A `%{ ... }` sequence is a directive, which allows for conditional results and iteration over collections, similar to conditional and `for` expressions.

The following directives are supported:

- The `%{if <BOOL>}`/`%{else}`/`%{endif}` directive chooses between two templates based on the value of a bool expression:

```
"Hello, %{ if var.name != "" }${var.name}%{ else }unnamed%{ endif }!"
```

- The `else` portion may be omitted, in which case the result is an empty string if the condition expression returns `false`. 

- The `%{for <NAME> in <COLLECTION>}` / `%{endfor}` directive iterates over the elements of a given collection or structural value and evaluates a given template once for each element, concatenating the results together:

```
<<EOT
%{ for ip in aws_instance.example[*].private_ip }
server ${ip}
%{ endfor }
EOT

```

The name given immediately after the `for` keyword is used as a temporary variable name which can then be referenced from the nested template.

### Operators

https://developer.hashicorp.com/terraform/language/expressions/operators 

An operator is a type of expression that transforms or combines one or more other expressions. Operators either combine two values in some way to produce a third result value, or transform a single given value to produce a single result. 

### Conditional Expressions

https://developer.hashicorp.com/terraform/language/expressions/conditionals 

A conditional expression uses the value of a boolean expression to select one of two values.

The syntax of a conditional expression is as follows:

```
condition ? true_val : false_val
```

If `condition` is `true` then the result is `true_val`. If `condition` is `false` then the result is `false_val`.

A common use of conditional expressions is to define defaults to replace invalid values:

```
var.a != "" ? var.a : "default-a"
```

If `var.a` is an empty string then the result is `"default-a"`, but otherwise it is the actual value of `var.a`.


### for Expressions

https://developer.hashicorp.com/terraform/language/expressions/for 

A `for` expression creates a complex type value by transforming another complex type value. Each element in the input value can correspond to either one or zero values in the result, and an arbitrary expression can be used to transform each input element into an output element.

For example, if `var.list` were a list of strings, then the following expression would produce a tuple of strings with all-uppercase letters:


```
[for s in var.list : upper(s)]
```
This `for` expression iterates over each element of `var.list`, and then evaluates the expression `upper(s)` with `s` set to each respective element. It then builds a new tuple value with all of the results of executing that expression in the same order.


For a map or object type, like above, the `k` symbol refers to the key or attribute name of the current element.
```
[for k, v in var.map : length(k) + length(v)]
```

You can also use the two-symbol form with lists and tuples, in which case the additional symbol is the index of each element starting from zero, which conventionally has the symbol name `i` or `idx` unless it's helpful to choose a more specific name:

```
[for i, v in var.list : "${i} is ${v}"]
```

The type of brackets around the for expression decide what type of result it produces.

The above example uses `[` and `]`, which produces a `tuple`. If you use `{` and `}` instead, the result is an `object` and you must provide two result expressions that are separated by the => symbol:

### Splat Expressions

https://developer.hashicorp.com/terraform/language/expressions/splat

A splat expression provides a more concise way to express a common operation that could otherwise be performed with a `for` expression. 

If `var.list` is a list of objects that all have an attribute `id`, then a list of the ids could be produced with the following `for` expression:

```
[for o in var.list : o.id]
```
This is equivalent to the following ***splat*** expression:

```
var.list[*].id
```

The special [*] symbol iterates over all of the elements of the list given to its left and accesses from each one the attribute name given on its right. A splat expression can also be used to access attributes and indexes from lists of complex types by extending the sequence of operations to the right of the symbol:

```
var.list[*].interfaces[0].name
```




##

### Terraform Console

To enter into Terraform Console, `terraform console`

#### Using Interpolation

```
"Hello World"
```

```
"Hello World \n"
```

If you have set a variable, you can use it via interpolation 
```
"Adios ${var.hello}"
```

#### Using Directive

Use in `Terraform Console`:

If you set the variable `hello="Pratik"` which is set in terraform.tfvars file.


```
"Hello, %{ if var.hello != "" }${var.hello}%{ else }unnamed%{ endif }!"
```
For above, If variable `hello` is `NOT BLANK`, it will print `Hello Pratik!`


```
"Hello, %{if var.hello == "Pratik"}Champ%{ else }Unknown%{ endif }!"
```
For above, If variable `hello` is `Pratik`, it will print `Hello Champ!`

```
"Hello, %{if var.hello == "Pratik"}Champ%{ else }Unknown%{ endif }!"
```

For above, If variable `hello` is `BLANK`, it will print `Hello Unknown!`

### For Expression Examples (Including Syntax)

#### List
Just like string template, we have created a `list` to iterate. The list is `states=["andhra pradesh","west bengal","uttar pradesh","arunachal pradesh","jammu and kashmir","tamil nadu", "madhya pradesh"]` which is set in terraform.tfvars file.


```
[for s in var.states : lower(s)]
```

```
[for s in var.states : upper(s)]
```

To return it as Maps:

```
{for i, w in var.states : "${i}" => title(w)}
```

## 

#### Maps
For `MAPS`, to iterate over it you need a different syntax. We have created a `map` to iterate in the t`erraform.tfvars` by the name of `states_capital`. 

```
[for k, v in var.states_capital : length(k) + length(v)]
```

```
[for i, v in var.states_capital : "${i} is ${v}"]
```

```
[for i, v in var.states_capital : "${i}'s capital is ${upper(v)}"]
```

```
[for i, v in var.states_capital : "${title(i)}'s capital is ${upper(v)}"]
```
```
[for i, v in var.states_capital : "${upper(v)}"]
```
```
[for i, v in var.states_capital : "${title(i)}"]
```

#### Filtering

```
[for s in var.states : upper(s) if s != ""]
```

```
[for p,q in var.states_capital : upper(p) if q == "Kolkata"]
```

```
[for p,q in var.states_capital : upper(p) if q != "Kolkata"]
```
## 
#### Splats

```
[for m in var.states_capital_cm_splats : m.CM]
```

```
[for m in var.states_capital_cm_splats : m.Capital]
```

```
var.states_capital_cm_splats[*].CM
```
```
[for m in var.states_capital_cm_splats : upper(m.CM)]
```

