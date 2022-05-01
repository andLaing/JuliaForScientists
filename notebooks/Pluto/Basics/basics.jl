### A Pluto.jl notebook ###
# v0.19.3

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 867989c7-b57c-4a53-a2a1-a5602d9420df
using PlutoUI

# ╔═╡ 85d79e69-faf6-42cf-9e70-00e4e6a517a6
PlutoUI.TableOfContents(title="Basics of Julia (with Pluto)", indent=true)


# ╔═╡ 6452d551-eae6-410f-a824-0d66aeec048b
md"""
# Printing and assigning variables: Pluto has a personality
"""

# ╔═╡ 9cb0b62b-1f52-452b-b895-a1174d834896
md"""
## Printing
"""

# ╔═╡ 0d60f5d5-53d6-4014-af00-7a8b27a4a6a4
md"""
A funny quirk of Pluto is that stdoutput goes to the terminal, not to the notebook. Thus, if you use the function 'println()' for example, nothing will appear in the notebook but the result will be displayed in the terminal you launched Pluto from

(NB: Recent versions of PLUTO have finally yielded to the impure of heart and allow printing to the notebook. If you are using a recent PLUTO version, you will see the text printed in your notebook)
"""

# ╔═╡ c744a498-9d13-4dc3-9ede-e62190c72877
println("Pluto has a personality!")

# ╔═╡ 2c8e97e9-1bd3-4c39-939a-62f621f62929
md"""
Plutonians insist on using interpolation rather than printing. If you need to print to the notebook, though, use 'with_terminal()' as below:

(NB: Not needed for recent versions of Pluto)
"""

# ╔═╡ 2c44ff3a-bb46-40d1-829e-17fd2b56daab
with_terminal() do
	println("Pluto has a personality!")
end

# ╔═╡ dda18475-3f32-4e05-be03-518abb492a91
md"""
you can also use the macro `@info`
"""

# ╔═╡ 9092c9cf-d7aa-4eb6-a511-e1dd738ad488
@info "Pluto has a personality!"

# ╔═╡ a8d159d1-b820-48ed-a522-fab17ce897ee
md"""
## Assigning variables
"""

# ╔═╡ 03e6bd29-4907-4807-984f-8d20ec1e0f7e
md"""
Remember that in Pluto variables are immutable. Thus if you assign a variable

`my_variable = 69`
 
then you cannot do so in another cell:
 
`my_variable = 100.`

You will get an error message: `Multiple definitions for my_variable.`
  
"""

# ╔═╡ 94058bf4-29d1-4aeb-8f0f-252f0033560e
my_variable = 69

# ╔═╡ 8052538f-12f3-46e4-b9e9-25310e0cc787
#my_variable = 100

# ╔═╡ e13ebcee-cbaf-408b-9d77-3c84341fd187
md" Uncomment the cell above and see what happens."

# ╔═╡ aa4c31cf-b6c1-4bd7-a678-b3a7252ce215
md"""
You can find the type of your variable with `typeof()`
"""

# ╔═╡ dafdbdce-4689-4515-a0ef-0d80319a247f
md"""
If you define all your variables in the global scope (this is the default case), you will end up writing a large number of names (e.g., `my_variable1`, `my_variable2`) due to the immutability rule. This may be inconvenient. However, many of the variables you need in a notebook are local (think of them as local to a function). Using let... end blocks allows you to reuse names.
"""

# ╔═╡ 9914d6c7-a94c-4a96-92fc-fe6f11a55212
let
	x = 7
	y = x^2
	my_variable = x +y
	md"""
Here, inside the let block the value of `my_variable` is $my_variable and its type is $(typeof(my_variable))
"""
end

# ╔═╡ 446722a6-e08e-4bfa-9ba5-ed5518c1ef25
md"""
Here, outside the let block the value of `my_variable` is still $my_variable and its type is still $(typeof(my_variable)). This is because the only the last line of a block is returned to global scope (the markdown here) .
"""

# ╔═╡ 7ffb251d-a155-44fb-a0d5-75d5c33a4c9d
let
	x = 0.5
	y = x^3
	my_variable = x +y
	md"""
Here, inside the new let block the value of `my_variable` has changed to $my_variable and its type to $(typeof(my_variable)). Notice that I am also redefining `x` and `y`. This is no problem, because all of them are local to the block. 
"""
end

# ╔═╡ 8addc85a-bfad-45d0-b9e2-3ef53f2b73ee
md"""
Here, I am back to the global scope. The value of `my_variable` is $my_variable and its type is $(typeof(my_variable)). What do you think are the values of `x` and `y`? Check the box to find out $(@bind doxy CheckBox(default=false))
"""

# ╔═╡ 4a64f90c-f24e-4e08-b6b8-bca655228aef
if doxy
	md"""
variables `x` and `y` are local to the let...end block and thus are not defined in the global scope. If you try to invoke them you will get an error. Try to write `x` in a cell below and see what happens
	"""
end

# ╔═╡ 9b4c14c7-3d73-417f-aa8a-d2d1158434c5
md"""

## A bit more on interpolation:

The type of $(my_variable) is $(typeof(my_variable))

The type of $(pi) is $(typeof(pi))

The type of $(round(pi, sigdigits=5)) is $(typeof(round(pi)))

The type of "Julia" is $(typeof("Julia"))

In particular notice that in markdown mode (md) with triple quotes single quotes are still recognised as a string. Instead beware: 'cat' would not delimit a string and it would be in fact incorrect to use, since '' are used to delimit characters

The type of 'c' is $(typeof('c'))
"""

# ╔═╡ 589c2d44-e309-4c2b-8c0e-e90f7299982e
md"""
## Strings

We have already encountered strings and string interpolation. Strings are a fundamental type in Julia. Antyhing between double quotes is a string with single quotes are used to define characters, like in C and unlike in Python. Strings can be concatenated using the function `string()`. Let's see a few examples below.
"""

# ╔═╡ d16099c4-1004-4354-9fab-dbb2c748414d
string("Hello", " World")

# ╔═╡ fe35a4e4-339c-4621-8fd0-a869ca997800
md"""

Notice that we can turn a variable that admits interpolation into a string using the functionality below:
"""

# ╔═╡ 921d1e6c-28be-4dc0-9a42-e0c8da8c0211
string_my_variable = string("$my_variable")

# ╔═╡ 1f55905c-889c-42d8-abf8-4b0cfb47f694
typeof(string_my_variable)

# ╔═╡ 6ce94093-c5ba-42b1-af65-28bafec12b72
md"""

But of course the type of `string_my_variable` is String. Do you think you can cast the variable back to Int or Float? Check the box to find out $(@bind doparse CheckBox(default=false))
"""

# ╔═╡ 76330c85-34db-44f2-af47-0e81f61317af
if doparse
	
	md"""
You can use the parse function to turn a string into an Integer or a Float
	
- `parse(Int64, string_my_variable)` => $(parse(Int64, string_my_variable))
- `parse(Float64, string_my_variable)` => $(parse(Float64, string_my_variable))
	"""
	
end

# ╔═╡ 70b8c375-c4a2-42f5-8ca2-bb42e9a37ab5
md"""
# Math
"""

# ╔═╡ 5bcd7d59-b1b8-49bb-821c-47b441c3260d
md"""## Mathematical operations

Julia handles math as you expect. Power uses ^ rather than the annoying **. Try a few operations!

Operation | Type This
:------------ | :-------------:
add | +
subtract | -
multiply | *
divide | /
power | ^
"""

# ╔═╡ 8fb3aad2-ca3e-4f02-b058-c23c523f2b52
md"""
## Casting types

In Julia one can convert types, provided they are compatible. Reveal this MD (go to the left of notebook and click in the eye) to display the code of the examples: 


The type of $(my_variable) is $(typeof(my_variable))

The type of $(Float64(my_variable)) is $(typeof(Float64(my_variable)))

The ceiling of $pi is $(ceil(pi))

The floor of $pi is $(floor(pi))
"""

# ╔═╡ f23b022d-2afe-4acf-bf39-3ddcb4c391fe
begin
	people = 10
	avg = 2.5
	slices = 8
	pizzaWrongGuess = 1
	pizzas = pizzaWrongGuess
end

# ╔═╡ a71739cb-f275-4dab-85a3-2d23c917453e
md"""
## Pizza Slices

Let's try this out on a problem (and demonstrate how cool Pluto can be).  Let's say you want to order pizzas for $people people (**people = $people**) and each person wants $avg slices on average (**avg = $avg**).  A pizza has $slices slices per pizza (**slices = $slices**).  How many pizzas should you order (**pizzas = ?**)?  

So we have the following

Meaning | Variable
:------ | :--------:
Number of people | people
Average number of slices each person eats | avg
Number of slices on a piece of pizza | slices


"""

# ╔═╡ 4d50b919-41f6-4c9d-93b0-c10ad978baa5
begin
	md"""
I have defined in the cell below the values of people, avg and slices for you. The value of pizzas I have written down (**pizzas = $(pizzaWrongGuess)**) is not correct on purpose, please replace if by the right value (Warning: you need to *replace* the value **pizzas = $(pizzaWrongGuess)** by something else. If you try to write a new values for **pizzas** in another cell you will get an error. Remember, variables in Pluto (not in Julia) are inmmutable).

 As you can see below, the red square claims that the answer is not correct (it is not, the guess I have written down is wrong on purpose). Once you find the right value of **pizzas** magic will occur, thanks to cool functions defined at the end of this notebook. Enjoy it. 
	"""
end

# ╔═╡ 50be58f7-a9ea-4c79-8f28-2b60cb1efe1a
md"""
# Data Structures
"""

# ╔═╡ e377dc75-6636-45e7-8425-97881099de5c
md"""
## Tuples

Tuples are immutable ordered sequences of elements. Let's see an example:
"""

# ╔═╡ 6cc27225-29a3-4394-900c-018f479bf4b0
birds = ("sparrow", "hawk", "osprey", "eagle")

# ╔═╡ 3c145fa2-b572-45a0-b231-0985e68049e5
md"""
You can access to the elements of the tuple by index (remember, in Julia first index is 1, last index is `end`)
"""

# ╔═╡ be3091f1-5d2e-49f4-a80f-87dbb921120f
birds[1]

# ╔═╡ eaf322e0-19ff-4939-a5a9-7a259d7f3919
birds[end]

# ╔═╡ 0def0cd7-4031-4b09-a0e2-a45611d6b0b2
birds[1:2]

# ╔═╡ 4ab2fdb7-82c6-4d64-8d1d-abf0f53b2387
birds[3:end]

# ╔═╡ 71f0b5ab-cc1d-4056-b57a-09a495817789
md"""
Tuples can mix elements of different types
"""

# ╔═╡ e804799c-a7f3-4a49-ac29-6434438a93ef
mixedTuple =(1, 10.0, "string", pi)

# ╔═╡ c5338351-e9ce-4598-8368-6984d96c1db9
md"""
You can create named tuples:
"""

# ╔═╡ 7eb94659-d40d-4e23-94fa-122ddf3b783b
namedTuple =(integer=1, float=10.0, string="string", irrational=pi)

# ╔═╡ 448cdb0b-5f2f-43c6-80e7-02f3d090d26a
md"""
In a named tuple you can access the elements by index or by name (that is the purpose of it 😄)

"""

# ╔═╡ 5b60dc81-d169-4b7a-88c7-41b50ea4af49
namedTuple.integer

# ╔═╡ 3196ff4d-dda5-4b5e-b81e-856a90ad54ad
namedTuple.irrational

# ╔═╡ bc2e835c-e901-4fb9-b01b-98c1148f8a53
md"""
## Arrays

Arrays are *mutable* ordered sequence of elements. 
"""

# ╔═╡ 744d76ac-dd22-49fd-982a-722feca1803a
md"""
### Arrays : 1D

A 1D array  is a linear representation of elements. A 1D array can only have either a row or a column. It represents a type of list that can be accessed by subsequent memory locations.

Let's see a few arrays
"""

# ╔═╡ 75ccd60e-6618-40b6-91cb-d82127a19784
array_of_ints = [1,2,3]

# ╔═╡ 17a18aa3-2542-442a-8285-c423fe67175b
typeof(array_of_ints)

# ╔═╡ a91b9381-fbbc-46e0-88dc-527502feae8b
array_of_floats = [1.0,2.0,3.0]

# ╔═╡ a7cea225-eca5-4b3a-a5f4-f23ed5c26ce3
typeof(array_of_floats)

# ╔═╡ 3cd872dc-ccd0-491e-8a6f-312ae80d9b1c
array_of_pis = [pi,pi,pi]

# ╔═╡ e51174e2-f32b-4ac3-ae7c-f4d114d304c6
typeof(array_of_pis)

# ╔═╡ c4b2086b-cb8b-4607-9271-9c85a7ab6366
mixed_array = [1, 1.0, pi, "cat"]

# ╔═╡ bd4a7266-e6b5-43bf-a5fa-9c7373808e84
typeof(mixed_array)

# ╔═╡ a11bc63d-dcc8-4c11-a098-3e4a356d0946
md"""
### Arrays are lists: Access elements, `push!` and `pop!`

Try and access elements of the above arrays by index (hint: same as for tuples). Notice that our mixed array resembles a Python list, that is an ordered collection of elements, which can have any specific type. 

Pretty much in the spirit of lists (all the way back to LISP), we can push and pop elements of an array in Julia. However notice the syntax (`push!` and `pop!`). The exclamation mark (`!`) is used in Julia as a convention when the function modifies the contents of the structure, in this case the array (or more in general to denote that the function has side effects). `push!` adds an element to the end of an array and `pop!` removes the last element of an array.
"""

# ╔═╡ 3ef683e4-06cd-4e3b-b0e4-28acacb638d7
fibonacci = [1, 1, 2, 3, 5, 8, 13]

# ╔═╡ 5ae2c705-cca2-4ff7-b675-499dcdb3c697
push!(fibonacci,21)

# ╔═╡ 893e11fb-0e63-44bd-8dd9-73c916735d13
pop!(fibonacci)

# ╔═╡ 752ae022-db71-440f-a170-c3cc093e0a36
md"""
### 1D arrays can have 1D arrays as elements

So far, we have shown 1D arrays whose elements where scalars. But the elements of a 1D array can be anything (or at least anything that can be thrown into a list). In particular, A 1D array can have other 1D arrays as elements. Let's see an example.
"""

# ╔═╡ 7ce3ba32-e2fb-47b7-9010-e19889de6c59
a1d = [1,2,3,4,5]

# ╔═╡ 06303fb3-f2a5-4af1-8c94-ec598737346b
typeof(a1d)

# ╔═╡ 0ee7386d-6a62-4de1-a095-0114da6dab30
size(a1d)

# ╔═╡ 6874c651-f98a-4ee5-a6ea-fb79213e94c2
a1d1 =[[1,2], [3,4], [5,6]]

# ╔═╡ 2dcefadb-4373-48cc-9173-d9f1dec48a30
typeof(a1d1)

# ╔═╡ 548abc68-f3f4-4063-aaf9-2b46d80ef580
size(a1d1)

# ╔═╡ 91ba3e7b-8af3-49eb-b5f4-4b2f69c63ade
md"""
Notice that `a1d`and `a1d1`are both 1D arrays. The funcion `size`tells us that they have a single dimension, with length 5 in the first case and 3 in the second. On the other hand, each element of a1d is an Int64 (we can see this by looking at the `typeof(a1d)`) while each element of a1d1 is in itself an Array of Int64, as revelated by `typeof(a1d1)`.

We can access the elements of `a1d1` by index as expected:
"""

# ╔═╡ e7bfe48d-7d29-4a61-96d2-56ef5231c7f1
a1d1[1]

# ╔═╡ 94338b6f-5332-4e42-a533-6d96a6054baf
a1d1[1][1]

# ╔═╡ 1d8441e5-d866-44a1-9fc2-d3e1afd7a352
a1d1[1][2]

# ╔═╡ d1bfd9a4-308e-4df4-ac23-75655e5ae23f
md"""
### Arrays : 2D

In Julia a 2D array is a representation of items in the form of rows and columns. Unlike Vectors, 2D arrays are a tabular (or Matrix like) representation of data. A 2D array can be created by separating elements in a row with a blank space and rows with a semicolon:
"""

# ╔═╡ b0f4df4d-92cc-4160-b252-2568fd1ce212
A = [1 2; 3 4]

# ╔═╡ 8382da83-40a6-4217-952d-4f30e252d077
size(A)

# ╔═╡ 9ad1712b-1ac4-4d3e-a07e-6a71e2ce2211
md"""
Notice the type and the size! We have defined a 2 x 2 Matrix. We can now access the elements either linearly (in this case the index runs through the elements of the matrix column by column) or by row and column:
"""

# ╔═╡ c9732c0b-1632-4faf-9d4d-ddce3943f733
with_terminal() do
	for i in 1:4
		println("A[",i,"]=",A[i])
	end
end

# ╔═╡ 7a9ab539-a483-4732-b1e6-e533eee5f976
with_terminal() do
	for i in 1:2
		for j in 1:2
			println("A[",i,",",j,"]=",A[i,j])
		end
	end
end

# ╔═╡ 7c210f37-3e77-4799-89af-48b44b356687
md"""
### Arrays: 3D 

A 3D array (or multi-dimensional array) is an array of arrays. A 3D array is of the type NxNxN where combining arrays can be of any dimensions. A 3D array can be created with the use of `cat` or `reshape` commands.
"""

# ╔═╡ 2cc6a911-4767-4ab1-baea-129318a3c0a9
A3D = cat([1 2; 3 4], [5 6; 7 8], dims=3)

# ╔═╡ 5796b9ab-c4de-476c-8641-2998cf2d2dca
size(A3D)

# ╔═╡ 315d2f8b-e699-495e-8682-5480c5e6947d
md"""
Julia tells us everything that is going on! We have `cat` two matrices (each one 2x2) into a 3D array. The third dimension has two elements, each element is one of the matrices. We can, of course access by index)
"""

# ╔═╡ 70fb6792-f143-46e8-a53d-5c99e3013c60
with_terminal() do
	for i in 1:2
		for j in 1:2
			for k in 1:2
				println("A3D[",k,",",j,",",i,"]=",A3D[k,j,i])
			end
		end
	end
end

# ╔═╡ 035d9cd2-e4f7-425a-9201-2b249cd1eae5
md"""
### Arrays: slicing

We have already seen slicing with tuples (syntax for 1D arrays is identical). Slicing 2D and 3D arrays is equally intuitive. Below an example:
"""

# ╔═╡ 993281dd-9808-4853-9796-dae242831871
A3D[:,:,1]

# ╔═╡ 0ee6f52f-f94b-4cc8-9df6-6ad22d7ee3ee
A3D[:,:,2]

# ╔═╡ 8b15a315-0778-4ec7-acd5-de444292c293
A3D[:,1,1]

# ╔═╡ 643c9552-3002-4a23-84b8-382dda452b5c
A3D[1,:,1]

# ╔═╡ 7a4fa05a-c2eb-48d9-865c-918bd5759e55
A3D[1:2,1:2,1]

# ╔═╡ 6bd1f0e7-ab76-4ebb-b070-6f6ffe469b40
md"""
### Updating elements

Since arrays are mutable structures it is possible to update their elements. 
"""

# ╔═╡ f35c81d4-6e8c-4271-9655-60f573a22c26
A3D[1,1,1] = 10;

# ╔═╡ efd27e77-c0bf-498c-9f6f-bc863526fa51
A3D

# ╔═╡ 4dc83d7c-5b7e-48df-9ba1-49a818363d8e
A3D[:,:,2] = [50 60; 70 80];

# ╔═╡ 99c770dd-d568-4418-8531-22d4efb4df55
A3D

# ╔═╡ 8d68fdb7-90f1-474b-beff-165871f9a7c1
md"""
### Adding elements

Since arrays are mutable structures it is possible to add elements to them. 
"""

# ╔═╡ 9fec819b-142a-4f59-97c6-b808ffc22ef5
md"""
#### Functions `pushfirst!` and `insert!`

In addition to `push!` and `pop!` we have functions `pushfirst!` and `insert!`. 
"""

# ╔═╡ b56966e6-5470-4ba0-80b1-b09e87912fd8
greetings = ["Julians"]

# ╔═╡ 337fef54-0d44-4ca8-9b82-3cf675e1c082
pushfirst!(greetings, "Hello")

# ╔═╡ a9438afc-488e-4a7b-b06a-8bfec46c6e7a
insert!(greetings, 2, "dear")

# ╔═╡ 9c1a20f6-c327-4269-8357-756d7d23cb2f
md"""
#### Functions `cat`, `vcat`, `hcat` and `hvcat`

These functions can be used to concatenate arrays of higher dimension. 

Let's see and example. First, define a 1D vector (this is done expanding a *range*) 
"""

# ╔═╡ dc53c211-af89-4a93-819e-26d47403b11b
oneTo4 = collect(1:4)

# ╔═╡ 8bf88286-41b4-4e75-9e56-beca944cf621
md"One more 1D from another range:"

# ╔═╡ b959b45f-cf3e-4219-b339-b410d326d3c9
fiveTo20 = collect(5:5:20)

# ╔═╡ 012126c9-b31b-4b44-90e3-613e1742d82a
md"Let's concatenate both arrays along the first dimension:"

# ╔═╡ b8b9b8e5-1f27-4964-8888-27b1399b0344
cat(oneTo4, fiveTo20, dims=(1,1))

# ╔═╡ e3fa373a-a17e-4ea1-a476-516bed5de0fa
md"We can see that in this case we obtain a linear array. Insetead concatenating along the second dimension yields a 4x2 array"

# ╔═╡ 8ce85673-5dc5-45a7-9a1b-8c54cb1d2980
cat(oneTo4, fiveTo20, dims=(2,2))

# ╔═╡ d4a6e9b2-a5cf-4ecc-989c-4661b800116e
md"*Exercise* Try other combinations with dimensions. Do you understand the outuput?"

# ╔═╡ 3b273ef7-8c53-44d4-a255-c7bcc2b44d24
md"`vcat` is used to concatenate the given arrays along dimension 1."

# ╔═╡ 7c431a8e-450a-4cc5-abe3-6e8d2a3f530f
vcat(oneTo4, fiveTo20)

# ╔═╡ 8671e33f-3a4b-4236-86b6-21ed0f87a0ad
md"`hcat` is used to concatenate the given arrays along dimension 2."

# ╔═╡ e7e9373b-bdb1-4e9f-8f5d-df0697d05dc3
hcat(oneTo4, fiveTo20)

# ╔═╡ 6fed4357-e98f-4579-b09a-a8431b9fa251
md"`hvcat` is used to concatenate the given arrays along dimension 1 and 2. This is one way of making a 2x2 matrix"

# ╔═╡ c9ce2286-5bb6-41df-b387-3ebaa01ff906
begin
	xa, xb, xc, xd = 5, 10, 15, 20
	[xa xb; xc xd]
end

# ╔═╡ 02a9d429-d55f-4c1b-a4af-f580379826e4
md"And this is how you do it with `hvcat!`"

# ╔═╡ 22c22571-fbae-4694-ba9a-fefdb812f267
hvcat((2, 2), xa, xb, xc, xd)

# ╔═╡ 36cbdba6-5f9c-40fa-97b5-15da83b50a09
md"""
### Copying arrays

By default, arrays are assigned by reference: Let's recall that the value of A3D is
"""

# ╔═╡ a249edf7-e6e9-4fc4-b072-a3d6432e4cfd
A3D

# ╔═╡ 98a4b835-f576-4cc9-a0e7-8e90bcd719bb
md" Let us know define `B3D` as a reference to `A3D`"

# ╔═╡ 4397f143-7a93-4cdc-a6a8-542c61eeca54
B3D = A3D

# ╔═╡ f6a47bd4-9b96-43bb-9e57-cda9d01ce442
md"Check the box to change `B3D` and display its new value $(@bind dob3d CheckBox(default=false)) "

# ╔═╡ 0dca9cfc-a817-458b-91e2-12672726e11e
if dob3d
	B3D[1,1,1] = 1
	B3D[:,:,2] = hvcat((2, 2), 5, 6, 7, 8) 
	B3D
end

# ╔═╡ e2a2d49c-89da-47c1-ac02-53cc2b87889e
md"Can you guess what happened to `A3D`? Check the box to find out the value of A3D $(@bind doa3d CheckBox(default=false))"

# ╔═╡ 3c89bdad-2779-4c0d-ad9c-726438a64273

md"""Ooops! `A3D` has also changed, since `B3D` who was a reference to it changed. So if you want to avoid chaning the original array (at the expense of time invested in copying) use function `copy`. This is the value of A3D"""
	


# ╔═╡ 7346873e-a22e-46a4-9eb6-fad6b5713aa0
md"Ooops! `A3D` has also changed, since `B3D` which was a reference to it changed. So if you want to avoid changing the original array (at the expense of time invested in copying) use function `copy`"

# ╔═╡ 65a09c10-d2d1-408e-8616-952b3e2c165b
C3D = copy(A3D)

# ╔═╡ 5cd817ea-6773-4226-96a0-e90055db9c23
md"""
`C3D` contains a copy of `A3D` (so is not a reference to it). Lets change the value of `C3D`
"""

# ╔═╡ c90ca787-029f-4460-92d7-96d563472c5b
begin
	C3D[1,1,1] = 10
	C3D[:,:,2] = hvcat((2, 2), 50, 60, 70, 80) 
	C3D
end

# ╔═╡ 2ea0cfde-d2bf-4c36-b094-1659a1d742ec
md"""
`C3D` has changed, but `A3D` has still the value that we got above
"""

# ╔═╡ e8ab6679-d64b-4ea3-8b58-5909d089b388
A3D

# ╔═╡ af05de92-535a-4228-a721-76f82946b3ec
md"""
### A few useful functions
 
"""

# ╔═╡ 2c6dac28-fbc8-4f26-a765-c214916fc01b
md"""
`count` counts the number of elements in the specified array for which the given predicate `p` returns `true` and if `p` is omitted, counts the number of `true` elements in the given collection of boolean values.

For instance we can count the number of integers in the array `fibonacci`

"""

# ╔═╡ 28b2379d-8b80-44eb-a73d-78f58dfb353e
typeof(fibonacci)

# ╔═╡ 0e325443-3f28-4782-9028-dc6c0417dfea
count(i->(typeof(i) == Int64), fibonacci)

# ╔═╡ baf6cc4d-561e-4789-82eb-f841f7cc9e4b
md"""
If no predicate is specified, `count` counts the number of trues in the array
"""

# ╔═╡ 4f7dcd44-66f6-4de5-af96-efbfa14467f1
count([true, true, true, false, false, true])

# ╔═╡ 1968f2c3-1962-4b55-88f7-b50ad0c9c583
md" `findall` and cousins return the indexes of trues in an array"

# ╔═╡ 7171fa3b-78b2-44d6-9a38-b84632fd1cd4
findall([true, true, true, false, false, true])

# ╔═╡ bde77270-c229-4dba-a49a-fe4d9ac6a72d
findfirst([true, true, true, false, false, true])

# ╔═╡ 78e76756-9606-479e-93e2-395f659c0d8a
findlast([true, true, true, false, false, true])

# ╔═╡ b2feb05d-a4c5-4ab6-a46f-8bbe49614c9f
md" `length` `ndims` and `size` give information about the array dimensions"

# ╔═╡ 2806e434-624d-403d-a20c-94a2a5d04cf3
length(fibonacci)

# ╔═╡ 4918b995-5a70-4710-9db5-30f2d6d472d4
ndims(A3D)

# ╔═╡ b58ba9a0-ea1b-4a0e-881d-234049d9fd26
size(A3D)

# ╔═╡ 5ed29145-a255-4128-beb0-df42a64f2428
md"""## Dictionaries

If we have sets of data related to one another, we may choose to store that data in a dictionary. We can create a dictionary using the `Dict()` function, which we can initialize as an empty dictionary or one storing key, value pairs.

Syntax:
```julia
Dict(key1 => value1, key2 => value2, ...)
```

A good example is a contacts list, where we associate names with phone numbers.
"""

# ╔═╡ ac523ee2-ce6d-47b6-8cdc-2e0383889395
myphonebook = Dict("Aure" => "867-5309", "Lola" => "555-2368", "Charly" => "899-3241")

# ╔═╡ 06153258-a4a1-4687-96ea-be1a59968fed
md"""
In this example, each name and number is a "key" and "value" pair. We can grab Jenny's number (a value) using the associated key
"""

# ╔═╡ f8fddd22-6b9b-4b3e-9165-5368080dc19d
myphonebook["Aure"]

# ╔═╡ 59beabdd-6964-499a-9c9c-62bc96f94c41
md"""
We can add another entry to this dictionary as follows
"""

# ╔═╡ 576f2f4f-812e-4276-bc95-7d0f4ff24af7
myphonebook["Kramer"] = "555-FILK"

# ╔═╡ c4c678ee-fcc9-4981-9b2f-92287988823c
md"""
We can delete Kramer from our contact list - and simultaneously grab his number - by using `pop!`
"""

# ╔═╡ 0aa12dee-f9be-4d68-a595-e87b8179927e
pop!(myphonebook, "Kramer")

# ╔═╡ cbee8612-07ed-41d5-8a8d-f11638ad0813
md"""
Unlike tuples and arrays, dictionaries are not ordered. So, we can't index into them.
(try myphonebook[1] and see what happens)
"""

# ╔═╡ 08712c3e-03c9-4735-8600-f3e3eef5ea01
md"""
We can acess the dictionary `keys`, `values` or `pairs` using the corresponding functions.
"""

# ╔═╡ bbe60afc-9cf3-4e36-86ab-a8231d960f35
keys(myphonebook)

# ╔═╡ a0148b25-4ee8-48e9-a15f-d3906b8d6bb2
values(myphonebook)

# ╔═╡ 1c96177b-3c13-4d96-98ee-576e8b86d886
pairs(myphonebook)

# ╔═╡ e6b0b694-bdae-4751-a404-9cffffe739ca
md"""
We can iterate over a dictionary
"""

# ╔═╡ cc577631-ae90-46bc-998e-a50030f8f906
with_terminal() do
	for (i,j) in myphonebook
		println("key = ", i, " value = ", j)
	end
end

# ╔═╡ 14b00871-d521-4388-bb2e-e0611848527c
md"""
# Loops

## while loops

The syntax for a `while` is

```julia
while *condition*
    *loop body*
end
```

For example, we could use `while` to count or to iterate over an array.
"""

# ╔═╡ 1b754152-e5f6-4c59-bb32-7f6dd63ce5c5
with_terminal() do
	n = 0
	while n < 10
	    n += 1
	    println(n)
	end
end

# ╔═╡ cc1dc0bd-2a13-4179-94d9-3c3905bb552f
myfriends = ["Ted", "Robyn", "Barney", "Lily", "Marshall"]

# ╔═╡ 04355f6f-4003-4100-b040-b49b7f319f00
with_terminal() do
	i = 1
	while i <= length(myfriends)
	    friend = myfriends[i]
	    println("Hi $friend, it's great to see you!")
	    i += 1
	end
end

# ╔═╡ c353c837-f5fc-474c-9103-ed3f6898d513
md"""
## for loops

The syntax for a `for` loop is

```julia
for *var* in *loop iterable*
    *loop body*
end
```

We could use a for loop to generate the same results as either of the examples above:
"""

# ╔═╡ b37ca7c8-b507-4a57-a4cb-8a0d56a560d3
with_terminal() do
	for n in 1:10
	    println(n)
	end
end

# ╔═╡ 70d89005-e2ac-4596-8700-032460f304d0
with_terminal() do
	for friend in myfriends
	    println("Hi $friend, it's great to see you!")
	end
end

# ╔═╡ a8f188cb-aa6e-492d-ad67-f9ce108ad841
md"""
A typical use of a `for` loop is to fill a vector or table. 

As an example let's create an addition tables, where the value of every entry is the sum of its row and column indices. Let's start with a 5x5 array as an example. 

Note that we iterate over this array via column-major loops in order to get the best performance. More information about fast indexing of multidimensional arrays inside nested loops can be found [here] (https://docs.julialang.org/en/v1/manual/performance-tips/#Access-arrays-in-memory-order,-along-columns-1).

First, we initialize the array with zeros using the handy function `fill`.
"""

# ╔═╡ 7f26e989-656c-4c71-af49-2c66cf374380
begin
	m, n = 5, 5
	mytable = fill(0, (m, n))
end

# ╔═╡ 384d41ad-a426-4703-9dcf-c4d9524b9d88
md"""
Now we fill each element of the matrix looping via column-major:
"""

# ╔═╡ 8ee6115b-65a1-423a-861a-9a4578aaff8d
for j in 1:n
    for i in 1:m
        mytable[i, j] = i + j
    end
end

# ╔═╡ 7df7d730-163f-42d9-8a47-3075d713589d
mytable

# ╔═╡ 87f51ca5-923c-469a-aecb-1886e5f45027
md"""
## Array comprehension

A cooler way to do the same operation (it is more compact and makes you feel smarter, although is basically the same operation) is an Array comprehension (list comprehension in Python). Notice that inner loop goes leftmost.
"""

# ╔═╡ e917fbae-b6d7-4708-b5fe-7c729e8a56eb
cooltable = [i + j for i in 1:m, j in 1:n]

# ╔═╡ c33ea1b5-0b32-4c2b-a1fc-4e470ed7807a
md"""
The same trick works for Dicts as well:
"""

# ╔═╡ 06627f1f-0cd4-4512-b69d-e7c3215586a9
tensquares = Dict( i => i^2 for i in 1:10)

# ╔═╡ 6bd9acf1-7d2a-4047-b46b-f93befd5956d
md"""

# Conditionals

## `if` 


```julia
if *condition 1*
    *option 1*
elseif *condition 2*
    *option 2*
else
    *option 3*
end
```

We have already used `if` in this notebook, specifically to perform the magic in the pizza problem. Let look at it now in detail. Below I defined the condition to be **green**. Try changing the condition to blue, red and white. Do you understand the ouput when the selected condition is **white**?
"""

# ╔═╡ 2effc425-2819-4291-9fd8-2e805c2d09e8
condition="green"

# ╔═╡ 5d4167cb-80dd-4f52-8373-e71ba4d55000
md"""OK, that is pretty cool, but the stock messages that we get from our cool pizza functions refer to the pizza problem, they could me more generic. We will try and improve them later. 
"""

# ╔═╡ eb0d2b75-9809-4c81-84ed-cd9048e8b62d
md"""
### ternary operators

ternary operator have the syntax

```julia
a ? b : c
```

which equates to 

```julia
if a
    b
else
    c
end
```

Suppose that we want to print green condition if a number is divisible by both 3 and 5, red condition otherwise. We could do it like this
"""

# ╔═╡ ba42e2f3-876b-492f-b15b-ade14de59dbc
N=15

# ╔═╡ df8e5a01-6994-4b11-a382-e74e75ffb212
md"""
The above works because the condition `(N % 3 == 0) && (N % 5 == 0)` evaluates to `true`. 

`&&`denotes `and` (`||`denotes `or`) and `%` computes the remainder after division
"""

# ╔═╡ c88f2309-05b7-4439-b8e9-4ce17342e654
md"""
# Functions
"""

# ╔═╡ 419c525a-0570-4830-ba06-68c5aa6a8954
md"""
Rather than the three `pizza functions` that we have used so far, we can define a more generic cool function to improve our "system condition" messaging. Let's try:
"""

# ╔═╡ c60c6d6f-4c76-4823-a5a6-366e52939fc3
coolf(status, msg, text) = Markdown.MD(Markdown.Admonition(status, msg, [text]))

# ╔═╡ a2e6feb7-c8b9-4079-89d2-822e1c248dbb
md"""

And see its application:
"""

# ╔═╡ a33e082d-5812-4dc9-b5f2-57e9ae7d7ab6
coolf("warning", "This is grey condition", md"The system works but fixes may be necessary")

# ╔═╡ 1f52b11f-3a3a-41a0-9313-3b4280661ebe
coolf("correct", "This is green condition", md"All systems work")

# ╔═╡ eaaa9648-2398-42d1-8d2d-f480c182487a
coolf("danger", "This is red condition", md"All systems red")

# ╔═╡ 5cb54a33-7211-472f-b98f-fe7676af1770
md"""
Honestly, though, our cool function is just a wrapper of another function, one that allows us to manipulate Markdown (MD) admonitions. You can learn more about Markdown
[here](https://docs.julialang.org/en/v1/stdlib/Markdown/).

To understand better what `coolf` does, we note that MD defines four admonitions:
`note/info`, `warning`, `danger`, and `tip`. We can see them in action in the cell below:
"""

# ╔═╡ e62106d9-59e4-4f08-902a-a6c51c6ae512
md"""
!!! note

    This is the content of the note.

!!! warning "Beware!"

    And this is another one.

    This warning admonition has a custom title: `"Beware!"`.

!!! danger "All systems Red"

	Just another custom title.

!!! tip

	And this is a tip
"""

# ╔═╡ d8247d69-578f-4662-8b6e-dc6e6bf446f3
md"""

For our system status function, we want to "redefine" the standard HD notation. We could use a dictionary for this:
"""

# ╔═╡ ba7d7545-913f-4cb7-8571-7bd28d6834ea
sysdic = Dict("blue" =>"note", "olive" =>"warning", "red" =>"danger", "green" =>"tip")

# ╔═╡ e98c21f9-ba54-4a13-997b-7c3794def894
md"""
we can now rewrite our function like this: 
"""

# ╔═╡ a0ccbfd2-7759-4d7a-9194-86881a84776e
function system_function(color, header, text)
	sysdic = Dict("blue" =>"note", "olive" =>"warning", "red" =>"danger", "green" =>"tip")
	Markdown.MD(Markdown.Admonition(sysdic[color], header, [text]))
end

# ╔═╡ 00a824e0-e4e9-40bc-aacb-f922542e1669
md"""
Notice that the dictionary allow us to expose to the user the colors that we want. Also notice that there is no return (although we could have used it). The function returns the last expression before the end
"""

# ╔═╡ c04d08c4-a7d0-4983-bc96-58ffd1a33d54
system_function("blue", "System is in a blue condition", md"Rustian ships may be nearby")

# ╔═╡ 8f3c1944-dda8-49c9-b6c1-ead7d7d9c4af
system_function("olive", "System is in a olive condition", md"Pythonian ships detected in the solar system")

# ╔═╡ 059481a3-201b-4242-b5df-8afc6b88b1b8
system_function("green", "System is in a green condition", md"All devices work correctly")

# ╔═╡ f1791757-01f2-4065-a213-6877b16c1640
system_function("red", "System is in a red condition", md"All systems red!")

# ╔═╡ 6b3ced7a-23f0-4b92-8ad6-66c675163223
md"""
But what happens if you call `system_function` with color `white`. Try it. Do you understand the cause of the trouble? Can you fix it?
"""

# ╔═╡ 7b38ef1a-984d-4ed3-8a37-0cf9e774b57c
md"""
Let's now write a function of our own, rather than a wrapper. We want to be able to define tables of arbitrary size and return them with the sum of rows and columns. 
"""

# ╔═╡ 3f230302-b1a6-4e0c-a035-cb18640e9d49
function sum_of_rows_and_columns(m,n)
	mytable = fill(0, (m, n))
	[i + j for i in 1:m, j in 1:n]
end

# ╔═╡ 115c830a-ff1a-495b-b06e-c90a1aecd2fe
sum_of_rows_and_columns(5,5)

# ╔═╡ b7d77ab4-b560-4322-aef6-e0d89ea5d50e
md"""
Nice! But our function could be generalized. After all what we are doing is an operation over rows (`i`) and columns (`j`), specifically `i+j`. But what if we want to fill the table with, say, the same *squared*?

We could, of course write another function. But there is a better way. We can pass a function to our function, specifying which operation we want to do.
"""

# ╔═╡ 0bb83cf4-f631-4618-a925-39db287935d4
function operate_on_rows_and_columns(m,n, f)
	mytable = fill(0, (m, n))
	[f(i,j) for i in 1:m, j in 1:n]
end

# ╔═╡ 10883a86-041b-4f03-8302-8764c1922c02
md"""
Let's start with the sum of rows and columns, as before:
"""

# ╔═╡ 2c5ad4f1-4e43-4073-8561-d364214c39b2
operate_on_rows_and_columns(5, 5, (x,y) -> x+y)

# ╔═╡ 025f88d3-8a00-4e18-b536-fced8b8605f9
md"""
Terrific! We have used a `lambda function` (e.g., an anonymous function) to define the sum of the two indices. Now, if we want to square them:
"""

# ╔═╡ 15a5bba7-de92-43f2-862f-bd08bab16afc
operate_on_rows_and_columns(5, 5, (x,y) -> x^2+y^2)

# ╔═╡ 9e5d904f-8e85-4033-9605-58deda852aa0
md"""
But what happens if you mystype one of the dimensions, calling the function say with `5.0, 5` rather than `5, 5`. Try it. Julia complains, since the dimensions are used by function `fill` and are expected to be integer. So let's write another version that forces `(m, n)` to be integers.
"""

# ╔═╡ 69bd6db7-fd23-4c64-8a92-0fc7ef6308f9
function operate_on_rows_and_columns2(m::Int64, n::Int64, f)
	mytable = fill(0, (m, n))
	[f(i,j) for i in 1:m, j in 1:n]
end

# ╔═╡ 3352db35-be56-438c-9761-ab684d3f7fd1
md"""
Try now to call the function making the same mistake as before. Julia will refuse to call `operate_on_rows_and_columns2` with a `Flota64`. We have explicitely declared that `m` and `n` must be integers (specifically `Int64`) and the compiler won't allow otherwise. 
"""

# ╔═╡ 4f7c345f-08f7-491a-b4d3-ba5adaa682c8
md"""
But suppose that you are so sloppy that typos happen time and again. Is there a way that you can protect yourself against your sloppiness? The answer is Yes. Meet Julia's multiple dispatch.
"""

# ╔═╡ e920fc66-7a74-412e-88a5-8509dd29f64d
operate_on_rows_and_columns2(m::Float64, n::Int64, f) = operate_on_rows_and_columns2(Int64(m), n, f)

# ╔═╡ 69cbf22f-b566-4d4d-af03-877626f4535b
operate_on_rows_and_columns2(m::Int64, n::Float64, f) = operate_on_rows_and_columns2(m, Int64(n), f)

# ╔═╡ b64683c8-84fa-4bc6-a7c1-68aa4d72964c
operate_on_rows_and_columns2(m::Float64, n::Float64, f) = operate_on_rows_and_columns2(Int64(m), Int64(n), f)

# ╔═╡ be5a2a54-0cbf-4b91-bbca-7067c36cb7b4
operate_on_rows_and_columns2(5.0, 5, (x,y) -> x^2+y^2)

# ╔═╡ 9f644b86-5801-444d-b470-6b75d0871bd5
operate_on_rows_and_columns2(5, 5.0, (x,y) -> x^2+y^2)

# ╔═╡ c7c85ce4-d529-4b7e-9b90-e91b1985ad52
operate_on_rows_and_columns2(5.0, 5.0, (x,y) -> x^2+y^2)

# ╔═╡ 133de5fe-2ac0-4fd1-96a8-6bbb572b8860
md"""
OK, now you are allowed to be sloppy (at your risks and perils). Notices that the
function `operate_on_rows_and_columns2` is now a "generic function with 4 methods". The magic of Julia's multiple dispatch works like this:

- Our first method defined a function in which the two dimensions were integers. When we call the function with two integers as arguments, julia will look for that particular method and will instantiate it.
- Methods 2,3 and 4 defined a function in which one of the two arguments or both could be floats. In each case, we simply call the first method after casting the float to integer. Notice that if you are megasloppy and pass, say, 5.1, you will get a crash because you cannot cast 5.1 to an integer. 
"""

# ╔═╡ d82b7825-991d-4384-9229-c97063857447
md"""
# Cool functions

## Pizza functions

Below you can find the cool functions used to display info in the Math problem. Notice that they are defined at the end of the notebook. In a Jupyter notebook that would cause problems in first execution, becuase Jupyter notebooks are sequential. In Pluto, though, functions (and variables) can be defined anywhere, since the state of the whole notebook is always updated. 
"""

# ╔═╡ 6e3414f4-c090-4956-86c6-c685d1c5b425
almost(text) = Markdown.MD(Markdown.Admonition("warning", "Almost there!", [text]));

# ╔═╡ 5e490d3f-cd2f-4b4b-9cd0-01d2409fe023
keep_working(text=md"The answer is not quite right.") = Markdown.MD(Markdown.Admonition("danger", "Keep working on it!", [text]));

# ╔═╡ 13c8e7e3-6c16-4aaf-a610-dc7689f9ef05
correct(text=md"Great! You got the right answer! Let's move on to the next section.") = Markdown.MD(Markdown.Admonition("correct", "Got it!", [text]));

# ╔═╡ 5b43cb05-d7f8-417f-9d72-dca740020f0e
if pizzas == people * avg / slices
	almost(md"Yes that is right! But we should round $pizzas up to an integer, otherwise the restaurant will be confused. 

Try `ceil(...)`!")
elseif pizzas == ceil(people * avg / slices)
	correct(md"Yes that is right, that's a lot of pizza! Excellent, you figured out we need to round up the number of pizzas!")
else
	keep_working()
end

# ╔═╡ 0c569d35-f402-4c18-a9ba-8367e48e3e70
if condition == "blue"
	almost(md"Blue condition selected")
elseif condition == "green"
	correct(md"green condition selected")
else
	keep_working("red condition selected")
end

# ╔═╡ 0ad312a4-d7c8-4074-b0f1-b83191b3d267
(N % 3 == 0) && (N % 5 == 0) ? correct(md"Green condition selected") : keep_working("red condition selected")

# ╔═╡ 160d160d-9196-43a2-be59-2fbce7ba504b
md"""

## System function

Below you can find a fixed version of `system_function` that does not crash if you call with with an unknown color 
"""

# ╔═╡ 21777ceb-6c49-4c22-a2cc-f0e5e3a7aa99
function system_function2(color, header, text)
	sysdic = Dict("blue" =>"note", "olive" =>"warning", "red" =>"danger", "green" =>"tip")

	if color in keys(sysdic)
		Markdown.MD(Markdown.Admonition(sysdic[color], header, [text]))
	else
		Markdown.MD(Markdown.Admonition(sysdic["red"], "color not found", [text]))
	end
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.38"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.2"
manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "621f4f3b4977325b9128d5fae7a8b4829a0c2222"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.4"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "670e559e5c8e191ded66fa9ea89c97f10376bb4c"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.38"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═867989c7-b57c-4a53-a2a1-a5602d9420df
# ╠═85d79e69-faf6-42cf-9e70-00e4e6a517a6
# ╟─6452d551-eae6-410f-a824-0d66aeec048b
# ╟─9cb0b62b-1f52-452b-b895-a1174d834896
# ╠═0d60f5d5-53d6-4014-af00-7a8b27a4a6a4
# ╠═c744a498-9d13-4dc3-9ede-e62190c72877
# ╠═2c8e97e9-1bd3-4c39-939a-62f621f62929
# ╠═2c44ff3a-bb46-40d1-829e-17fd2b56daab
# ╟─dda18475-3f32-4e05-be03-518abb492a91
# ╠═9092c9cf-d7aa-4eb6-a511-e1dd738ad488
# ╟─a8d159d1-b820-48ed-a522-fab17ce897ee
# ╟─03e6bd29-4907-4807-984f-8d20ec1e0f7e
# ╠═94058bf4-29d1-4aeb-8f0f-252f0033560e
# ╠═8052538f-12f3-46e4-b9e9-25310e0cc787
# ╠═e13ebcee-cbaf-408b-9d77-3c84341fd187
# ╟─aa4c31cf-b6c1-4bd7-a678-b3a7252ce215
# ╟─dafdbdce-4689-4515-a0ef-0d80319a247f
# ╠═9914d6c7-a94c-4a96-92fc-fe6f11a55212
# ╟─446722a6-e08e-4bfa-9ba5-ed5518c1ef25
# ╠═7ffb251d-a155-44fb-a0d5-75d5c33a4c9d
# ╟─8addc85a-bfad-45d0-b9e2-3ef53f2b73ee
# ╟─4a64f90c-f24e-4e08-b6b8-bca655228aef
# ╟─9b4c14c7-3d73-417f-aa8a-d2d1158434c5
# ╟─589c2d44-e309-4c2b-8c0e-e90f7299982e
# ╠═d16099c4-1004-4354-9fab-dbb2c748414d
# ╟─fe35a4e4-339c-4621-8fd0-a869ca997800
# ╠═921d1e6c-28be-4dc0-9a42-e0c8da8c0211
# ╠═1f55905c-889c-42d8-abf8-4b0cfb47f694
# ╠═6ce94093-c5ba-42b1-af65-28bafec12b72
# ╟─76330c85-34db-44f2-af47-0e81f61317af
# ╟─70b8c375-c4a2-42f5-8ca2-bb42e9a37ab5
# ╟─5bcd7d59-b1b8-49bb-821c-47b441c3260d
# ╟─8fb3aad2-ca3e-4f02-b058-c23c523f2b52
# ╟─a71739cb-f275-4dab-85a3-2d23c917453e
# ╟─4d50b919-41f6-4c9d-93b0-c10ad978baa5
# ╠═f23b022d-2afe-4acf-bf39-3ddcb4c391fe
# ╟─5b43cb05-d7f8-417f-9d72-dca740020f0e
# ╟─50be58f7-a9ea-4c79-8f28-2b60cb1efe1a
# ╟─e377dc75-6636-45e7-8425-97881099de5c
# ╠═6cc27225-29a3-4394-900c-018f479bf4b0
# ╟─3c145fa2-b572-45a0-b231-0985e68049e5
# ╠═be3091f1-5d2e-49f4-a80f-87dbb921120f
# ╠═eaf322e0-19ff-4939-a5a9-7a259d7f3919
# ╠═0def0cd7-4031-4b09-a0e2-a45611d6b0b2
# ╠═4ab2fdb7-82c6-4d64-8d1d-abf0f53b2387
# ╟─71f0b5ab-cc1d-4056-b57a-09a495817789
# ╟─e804799c-a7f3-4a49-ac29-6434438a93ef
# ╟─c5338351-e9ce-4598-8368-6984d96c1db9
# ╠═7eb94659-d40d-4e23-94fa-122ddf3b783b
# ╟─448cdb0b-5f2f-43c6-80e7-02f3d090d26a
# ╠═5b60dc81-d169-4b7a-88c7-41b50ea4af49
# ╠═3196ff4d-dda5-4b5e-b81e-856a90ad54ad
# ╟─bc2e835c-e901-4fb9-b01b-98c1148f8a53
# ╟─744d76ac-dd22-49fd-982a-722feca1803a
# ╠═75ccd60e-6618-40b6-91cb-d82127a19784
# ╠═17a18aa3-2542-442a-8285-c423fe67175b
# ╠═a91b9381-fbbc-46e0-88dc-527502feae8b
# ╠═a7cea225-eca5-4b3a-a5f4-f23ed5c26ce3
# ╠═3cd872dc-ccd0-491e-8a6f-312ae80d9b1c
# ╠═e51174e2-f32b-4ac3-ae7c-f4d114d304c6
# ╠═c4b2086b-cb8b-4607-9271-9c85a7ab6366
# ╠═bd4a7266-e6b5-43bf-a5fa-9c7373808e84
# ╟─a11bc63d-dcc8-4c11-a098-3e4a356d0946
# ╠═3ef683e4-06cd-4e3b-b0e4-28acacb638d7
# ╠═5ae2c705-cca2-4ff7-b675-499dcdb3c697
# ╠═893e11fb-0e63-44bd-8dd9-73c916735d13
# ╟─752ae022-db71-440f-a170-c3cc093e0a36
# ╠═7ce3ba32-e2fb-47b7-9010-e19889de6c59
# ╠═06303fb3-f2a5-4af1-8c94-ec598737346b
# ╠═0ee7386d-6a62-4de1-a095-0114da6dab30
# ╠═6874c651-f98a-4ee5-a6ea-fb79213e94c2
# ╠═2dcefadb-4373-48cc-9173-d9f1dec48a30
# ╠═548abc68-f3f4-4063-aaf9-2b46d80ef580
# ╟─91ba3e7b-8af3-49eb-b5f4-4b2f69c63ade
# ╠═e7bfe48d-7d29-4a61-96d2-56ef5231c7f1
# ╠═94338b6f-5332-4e42-a533-6d96a6054baf
# ╠═1d8441e5-d866-44a1-9fc2-d3e1afd7a352
# ╟─d1bfd9a4-308e-4df4-ac23-75655e5ae23f
# ╠═b0f4df4d-92cc-4160-b252-2568fd1ce212
# ╠═8382da83-40a6-4217-952d-4f30e252d077
# ╟─9ad1712b-1ac4-4d3e-a07e-6a71e2ce2211
# ╠═c9732c0b-1632-4faf-9d4d-ddce3943f733
# ╠═7a9ab539-a483-4732-b1e6-e533eee5f976
# ╟─7c210f37-3e77-4799-89af-48b44b356687
# ╠═2cc6a911-4767-4ab1-baea-129318a3c0a9
# ╠═5796b9ab-c4de-476c-8641-2998cf2d2dca
# ╟─315d2f8b-e699-495e-8682-5480c5e6947d
# ╠═70fb6792-f143-46e8-a53d-5c99e3013c60
# ╟─035d9cd2-e4f7-425a-9201-2b249cd1eae5
# ╠═993281dd-9808-4853-9796-dae242831871
# ╠═0ee6f52f-f94b-4cc8-9df6-6ad22d7ee3ee
# ╠═8b15a315-0778-4ec7-acd5-de444292c293
# ╠═643c9552-3002-4a23-84b8-382dda452b5c
# ╠═7a4fa05a-c2eb-48d9-865c-918bd5759e55
# ╟─6bd1f0e7-ab76-4ebb-b070-6f6ffe469b40
# ╠═f35c81d4-6e8c-4271-9655-60f573a22c26
# ╠═efd27e77-c0bf-498c-9f6f-bc863526fa51
# ╠═4dc83d7c-5b7e-48df-9ba1-49a818363d8e
# ╠═99c770dd-d568-4418-8531-22d4efb4df55
# ╟─8d68fdb7-90f1-474b-beff-165871f9a7c1
# ╟─9fec819b-142a-4f59-97c6-b808ffc22ef5
# ╠═b56966e6-5470-4ba0-80b1-b09e87912fd8
# ╠═337fef54-0d44-4ca8-9b82-3cf675e1c082
# ╠═a9438afc-488e-4a7b-b06a-8bfec46c6e7a
# ╟─9c1a20f6-c327-4269-8357-756d7d23cb2f
# ╠═dc53c211-af89-4a93-819e-26d47403b11b
# ╟─8bf88286-41b4-4e75-9e56-beca944cf621
# ╠═b959b45f-cf3e-4219-b339-b410d326d3c9
# ╟─012126c9-b31b-4b44-90e3-613e1742d82a
# ╠═b8b9b8e5-1f27-4964-8888-27b1399b0344
# ╟─e3fa373a-a17e-4ea1-a476-516bed5de0fa
# ╠═8ce85673-5dc5-45a7-9a1b-8c54cb1d2980
# ╟─d4a6e9b2-a5cf-4ecc-989c-4661b800116e
# ╟─3b273ef7-8c53-44d4-a255-c7bcc2b44d24
# ╠═7c431a8e-450a-4cc5-abe3-6e8d2a3f530f
# ╠═8671e33f-3a4b-4236-86b6-21ed0f87a0ad
# ╠═e7e9373b-bdb1-4e9f-8f5d-df0697d05dc3
# ╟─6fed4357-e98f-4579-b09a-a8431b9fa251
# ╠═c9ce2286-5bb6-41df-b387-3ebaa01ff906
# ╟─02a9d429-d55f-4c1b-a4af-f580379826e4
# ╠═22c22571-fbae-4694-ba9a-fefdb812f267
# ╠═36cbdba6-5f9c-40fa-97b5-15da83b50a09
# ╠═a249edf7-e6e9-4fc4-b072-a3d6432e4cfd
# ╠═98a4b835-f576-4cc9-a0e7-8e90bcd719bb
# ╠═4397f143-7a93-4cdc-a6a8-542c61eeca54
# ╠═f6a47bd4-9b96-43bb-9e57-cda9d01ce442
# ╟─0dca9cfc-a817-458b-91e2-12672726e11e
# ╟─e2a2d49c-89da-47c1-ac02-53cc2b87889e
# ╟─3c89bdad-2779-4c0d-ad9c-726438a64273
# ╟─7346873e-a22e-46a4-9eb6-fad6b5713aa0
# ╠═65a09c10-d2d1-408e-8616-952b3e2c165b
# ╟─5cd817ea-6773-4226-96a0-e90055db9c23
# ╠═c90ca787-029f-4460-92d7-96d563472c5b
# ╟─2ea0cfde-d2bf-4c36-b094-1659a1d742ec
# ╠═e8ab6679-d64b-4ea3-8b58-5909d089b388
# ╟─af05de92-535a-4228-a721-76f82946b3ec
# ╟─2c6dac28-fbc8-4f26-a765-c214916fc01b
# ╠═28b2379d-8b80-44eb-a73d-78f58dfb353e
# ╠═0e325443-3f28-4782-9028-dc6c0417dfea
# ╟─baf6cc4d-561e-4789-82eb-f841f7cc9e4b
# ╠═4f7dcd44-66f6-4de5-af96-efbfa14467f1
# ╟─1968f2c3-1962-4b55-88f7-b50ad0c9c583
# ╠═7171fa3b-78b2-44d6-9a38-b84632fd1cd4
# ╠═bde77270-c229-4dba-a49a-fe4d9ac6a72d
# ╠═78e76756-9606-479e-93e2-395f659c0d8a
# ╟─b2feb05d-a4c5-4ab6-a46f-8bbe49614c9f
# ╠═2806e434-624d-403d-a20c-94a2a5d04cf3
# ╠═4918b995-5a70-4710-9db5-30f2d6d472d4
# ╠═b58ba9a0-ea1b-4a0e-881d-234049d9fd26
# ╟─5ed29145-a255-4128-beb0-df42a64f2428
# ╠═ac523ee2-ce6d-47b6-8cdc-2e0383889395
# ╟─06153258-a4a1-4687-96ea-be1a59968fed
# ╟─f8fddd22-6b9b-4b3e-9165-5368080dc19d
# ╟─59beabdd-6964-499a-9c9c-62bc96f94c41
# ╠═576f2f4f-812e-4276-bc95-7d0f4ff24af7
# ╟─c4c678ee-fcc9-4981-9b2f-92287988823c
# ╠═0aa12dee-f9be-4d68-a595-e87b8179927e
# ╟─cbee8612-07ed-41d5-8a8d-f11638ad0813
# ╟─08712c3e-03c9-4735-8600-f3e3eef5ea01
# ╠═bbe60afc-9cf3-4e36-86ab-a8231d960f35
# ╠═a0148b25-4ee8-48e9-a15f-d3906b8d6bb2
# ╠═1c96177b-3c13-4d96-98ee-576e8b86d886
# ╟─e6b0b694-bdae-4751-a404-9cffffe739ca
# ╠═cc577631-ae90-46bc-998e-a50030f8f906
# ╟─14b00871-d521-4388-bb2e-e0611848527c
# ╠═1b754152-e5f6-4c59-bb32-7f6dd63ce5c5
# ╠═cc1dc0bd-2a13-4179-94d9-3c3905bb552f
# ╠═04355f6f-4003-4100-b040-b49b7f319f00
# ╟─c353c837-f5fc-474c-9103-ed3f6898d513
# ╠═b37ca7c8-b507-4a57-a4cb-8a0d56a560d3
# ╠═70d89005-e2ac-4596-8700-032460f304d0
# ╟─a8f188cb-aa6e-492d-ad67-f9ce108ad841
# ╠═7f26e989-656c-4c71-af49-2c66cf374380
# ╟─384d41ad-a426-4703-9dcf-c4d9524b9d88
# ╠═8ee6115b-65a1-423a-861a-9a4578aaff8d
# ╠═7df7d730-163f-42d9-8a47-3075d713589d
# ╟─87f51ca5-923c-469a-aecb-1886e5f45027
# ╠═e917fbae-b6d7-4708-b5fe-7c729e8a56eb
# ╟─c33ea1b5-0b32-4c2b-a1fc-4e470ed7807a
# ╠═06627f1f-0cd4-4512-b69d-e7c3215586a9
# ╟─6bd9acf1-7d2a-4047-b46b-f93befd5956d
# ╠═2effc425-2819-4291-9fd8-2e805c2d09e8
# ╟─0c569d35-f402-4c18-a9ba-8367e48e3e70
# ╟─5d4167cb-80dd-4f52-8373-e71ba4d55000
# ╟─eb0d2b75-9809-4c81-84ed-cd9048e8b62d
# ╠═ba42e2f3-876b-492f-b15b-ade14de59dbc
# ╠═0ad312a4-d7c8-4074-b0f1-b83191b3d267
# ╟─df8e5a01-6994-4b11-a382-e74e75ffb212
# ╟─c88f2309-05b7-4439-b8e9-4ce17342e654
# ╟─419c525a-0570-4830-ba06-68c5aa6a8954
# ╠═c60c6d6f-4c76-4823-a5a6-366e52939fc3
# ╟─a2e6feb7-c8b9-4079-89d2-822e1c248dbb
# ╠═a33e082d-5812-4dc9-b5f2-57e9ae7d7ab6
# ╠═1f52b11f-3a3a-41a0-9313-3b4280661ebe
# ╠═eaaa9648-2398-42d1-8d2d-f480c182487a
# ╟─5cb54a33-7211-472f-b98f-fe7676af1770
# ╟─e62106d9-59e4-4f08-902a-a6c51c6ae512
# ╟─d8247d69-578f-4662-8b6e-dc6e6bf446f3
# ╠═ba7d7545-913f-4cb7-8571-7bd28d6834ea
# ╟─e98c21f9-ba54-4a13-997b-7c3794def894
# ╠═a0ccbfd2-7759-4d7a-9194-86881a84776e
# ╟─00a824e0-e4e9-40bc-aacb-f922542e1669
# ╠═c04d08c4-a7d0-4983-bc96-58ffd1a33d54
# ╠═8f3c1944-dda8-49c9-b6c1-ead7d7d9c4af
# ╠═059481a3-201b-4242-b5df-8afc6b88b1b8
# ╠═f1791757-01f2-4065-a213-6877b16c1640
# ╟─6b3ced7a-23f0-4b92-8ad6-66c675163223
# ╟─7b38ef1a-984d-4ed3-8a37-0cf9e774b57c
# ╠═3f230302-b1a6-4e0c-a035-cb18640e9d49
# ╠═115c830a-ff1a-495b-b06e-c90a1aecd2fe
# ╟─b7d77ab4-b560-4322-aef6-e0d89ea5d50e
# ╠═0bb83cf4-f631-4618-a925-39db287935d4
# ╠═10883a86-041b-4f03-8302-8764c1922c02
# ╠═2c5ad4f1-4e43-4073-8561-d364214c39b2
# ╟─025f88d3-8a00-4e18-b536-fced8b8605f9
# ╠═15a5bba7-de92-43f2-862f-bd08bab16afc
# ╟─9e5d904f-8e85-4033-9605-58deda852aa0
# ╠═69bd6db7-fd23-4c64-8a92-0fc7ef6308f9
# ╟─3352db35-be56-438c-9761-ab684d3f7fd1
# ╟─4f7c345f-08f7-491a-b4d3-ba5adaa682c8
# ╠═e920fc66-7a74-412e-88a5-8509dd29f64d
# ╠═69cbf22f-b566-4d4d-af03-877626f4535b
# ╠═b64683c8-84fa-4bc6-a7c1-68aa4d72964c
# ╠═be5a2a54-0cbf-4b91-bbca-7067c36cb7b4
# ╠═9f644b86-5801-444d-b470-6b75d0871bd5
# ╠═c7c85ce4-d529-4b7e-9b90-e91b1985ad52
# ╟─133de5fe-2ac0-4fd1-96a8-6bbb572b8860
# ╟─d82b7825-991d-4384-9229-c97063857447
# ╠═6e3414f4-c090-4956-86c6-c685d1c5b425
# ╠═5e490d3f-cd2f-4b4b-9cd0-01d2409fe023
# ╠═13c8e7e3-6c16-4aaf-a610-dc7689f9ef05
# ╟─160d160d-9196-43a2-be59-2fbce7ba504b
# ╠═21777ceb-6c49-4c22-a2cc-f0e5e3a7aa99
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
