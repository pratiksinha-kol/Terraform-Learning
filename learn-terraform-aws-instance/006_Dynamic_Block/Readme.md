## Dynamic Blocks

https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks  

Terraform provides the dynamic block to create repeatable nested blocks within a resource. A dynamic block is similar to the for expression. 

A `dynamic` block iterates over a child resource and generates a nested block for each element of that resource.

You can dynamically construct repeatable nested blocks like `setting` using a special `dynamic` block type, which is supported inside `resource`, `data`, `provider`, and `provisioner` blocks.

A dynamic block consists of the following components:

|Component | Description |
|----------|--------------|   
|label | Specifies what kind of nested block to generate   |
|for_each  | The complex value to iterate over.|
| iterator | (optional) Sets the name of a temporary variable that represents the current element. If not provided, the name of the variable defaults to the label of the dynamic block. An iterator has two attributes: key and value. Key is the element index. Value is the element value.|
| content  | Defines the body of each generated block.|

A `dynamic` block can only generate attributes that belong to the resource type being created. It isn’t possible to generate meta-argument blocks like lifecycle. Some resource types have blocks with multiple levels of nesting. 
**[SOURCE](https://spacelift.io/blog/terraform-dynamic-blocks)**

_CREATING SECURITY GROUP USING DYNAMIC BLOCK_

**[SOURCE 1](https://learning-ocean.com/tutorials/terraform/terraform-security-group)**

**[SOURCE 2](https://www.cloudbolt.io/terraform-best-practices/terraform-dynamic-blocks/)**

