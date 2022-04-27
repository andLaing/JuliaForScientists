### A Pluto.jl notebook ###
# v0.18.1

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

# ╔═╡ 847a880f-d8ea-44c8-af9e-dd716a806381
begin
using Markdown
using InteractiveUtils
using PlutoUI
end

# ╔═╡ 0c448718-8c3d-462b-8a6c-8e28d17849c5
using Printf

# ╔═╡ e8fae5a2-3386-445c-8be4-bd3b9f151977
PlutoUI.TableOfContents(title="Pluto: Julia implementation of reactive notebooks", indent=true)

# ╔═╡ b129ba7c-953a-11ea-3379-17adae34924c
md"""# _Reactive Notebooks_

Pluto implements the concept of **reactive notebook** for the _Julia_ programming language. 

A reactive notebook is a notebook that is always kept up-to-date. So whenever its code is changed or a cell is deleted or moved, the notebook's outputs are automatically updated as if the notebook was executed fresh, from top to bottom.

Consider for example what happens if you run a Jupyter notebook with the following code:

```
	> cell 1: x = 1

	> cell 2: println('x =', x)

  	> cell 3: x = x+3
```

The first time you excecute cell 2, the results is `1`. Now you execute cell 3. If you execute cell 2 again, the result is `4`. Otherwise, cell 2 is stating a lie, since it still affirms that `x=1`, but `x` is now 4. So, the cost to pay for having independent cells in a conventional notebooks (like Jupyter) is *hidden state*. Unless we re-run continuously the notebook, we don't know the state of the variables.

The situation can get worse. Suppose that you rerun cell 2, getting now that `x = 4`. Then, you delete cell 3 from the notebook. Now, cell 2 is claiming that `x = 4` right after cell 1 has defined `x` as being one. 

While this may not seem a big deal for a simple example, hidden state may result in a serious problem in a notebook containing hundreds of lines of code. 

Read more [in this article] (https://www.nature.com/articles/d41586-021-01174-w) or in [this very fun tube by joel grus](https://www.youtube.com/watch?v=7jiPeIFXb6U)

In a reactive notebook hidden state does not exist. This means that the notebook updates itself each time a changed is introduced to keep the state updated. Let's see an example. Type the following code in the cells below:

```
	> x = 1
  
```

The result is x =1. BTW, if you try *println* the output will not go to the notebook but to the terminal. This is a somewhat weird quirk of Pluto (nobody's perfect).

Also, if you try to write the above two sentences in the same cells Pluto will complain. The convention in Pluto requires that you write either one sentence per cell of enclose multiple sentences in begin... end blocks. 

Now, suppose you want to change the state of x, writing a new cell below the two above (try it):


	> x = 2
 
 Yes, you get an error *Multiple definitions for x*. Pluto has binded the variable x to the value 1 and will not let you change its value. In other words, variables are **inmutable** in Pluto. This solves the most obvious case of hidden state. 
 
 Consider now a more subtle case: define the function:
 

 ```
  	
   f(x) = x +2
  
```

Type in a cell:

```
	>y= f(2)
```

Pluto automatically tells us that y=4, as expected. You would get the same behaviour in Jupyter.

The difference is that in Jupyter you could next *delete* the cell with the definition of the function and the value of y would still be 4 (which is senseless, since now the instruction **y = f(2)** refers to an undefined function). Instead, if you delete the cell with the definition of the function in Pluto you will get an error. *UndefVarError: f not defined*

The short story. You can't have hidden state in Pluto notebooks. Every time that you change something in the notebook it will update itself to keep the state clean. 


"""

# ╔═╡ d2713ff7-41a9-4c67-ba28-99f29687fab1
x = 2

# ╔═╡ b267cd55-009e-4da2-832b-1e98dfdd2759
md"""# _Interpolation_

Another useful feature of Pluto is the hability to implement *interpolation* in the markdown text. This allows to present the data in the markdown in terms of what has been computed in the code. For example:

X = $x

Interpolates the value of variable "x" defined in the cell below to the md text. 
"""

# ╔═╡ a7068203-02ac-40a1-ac35-c78f4ab20cb6
squareme(x) = x^2

# ╔═╡ 3bc3a5fc-2ed7-4894-b9ad-6e3e8b50f382
y = "Hello"

# ╔═╡ 952d4797-dd4c-46a0-b54a-d72de23dca17
z="World"

# ╔═╡ 1aeffd56-06e8-4c69-84ee-d70894a79861
chainstring(x,y) = string(x," ", y)

# ╔═╡ d593ca03-3504-4f3f-bd96-15d949f8824c
md"""# _Order does not matter_

In Jupyter notebooks, code is assumed to be executed sequentially (but there is no way to ensure that this is always the case, and this is the source of hidden state much of the time). In Pluto, the absence of hidden state allows one to place code in any order. For example:

Variable x, defined above this cell, has value $x

Variable y, defined below this cell, has value $y

Function **squareme** defined before this cell, takes the value of $x and squares it resulting in $(squareme(x))

Function **chainstring** defined below this cell, allows me to greet you,
$(chainstring(y,z))

"""

# ╔═╡ 3150bf1a-9555-11ea-306f-0fd4d9229a51
md""" # Binding variables

Pluto lets you `@bind` variables to HTML elements. As always, every time you change something, Pluto knows what to update!"""

# ╔═╡ f2c79746-9554-11ea-39ca-298fd09248ad
@bind rangevar html"<input type='range'>"

# ╔═╡ 9cbb36e1-61bd-4439-9f18-58e466f2cc79
md" The power level is $rangevar"

# ╔═╡ 3e5a0d51-a849-42f0-9a2c-b8e1a5d2a15e
md"## Input types

You can use _any_ DOM element that fires an `input` event. For example:"

# ╔═╡ 85f7a276-e13f-4bf1-a908-fca032894a16
md"""
`a = ` $(@bind a html"<input type=range >")

`b = ` $(@bind b html"<input type=text >")

`c = ` $(@bind c html"<input type=button value='Click'>")

`d = ` $(@bind d html"<input type=checkbox >")

`e = ` $(@bind e html"<select><option value='one'>First</option><option value='two'>Second</option></select>")

`f = ` $(@bind f html"<input type=color >")

"""

# ╔═╡ b3f3cec1-dc46-4bba-becc-bedba8b057f9
md"""
a = $a

b = $b

c = $c

d = $d

e = $e
"""

# ╔═╡ 7a89f893-b605-47a6-8f17-ab4f57ce49ef
md"""
## PlutoUI 

PlutoUI is a package that offers syntactic sugar to bind variables. To use it (as in this notebook) you need to include the line

`using PlutoUI`

See below some examples of use:
"""

# ╔═╡ 0e42e132-94cc-48c2-aaf7-ef81c2075f16
md""" ### A Slider
"""

# ╔═╡ f843be72-64de-427e-a3bf-202ce217f517
@bind xs Slider(5:15)

# ╔═╡ 1443687f-0052-49ca-a9d2-746dcf78763b
md" You have selected a slider value of  $xs"

# ╔═╡ 3dca2d86-45d2-4b75-9511-8a1a6f943c4e
md""" ### A Slider with range and default
"""

# ╔═╡ a42c49a7-ccf7-4867-a3d4-0f9dcc33f9ed
@bind ys Slider(20:0.1:30, default=25.5)

# ╔═╡ 255a6968-f4c4-4991-a789-5d926ccc0f6f
md" ou have selected a slider value of $ys"

# ╔═╡ 04c43494-30a0-4803-a4a0-3456cd30d93b
md"### A number field"

# ╔═╡ 789901e3-11ce-4626-aa75-9f4b8d4a574d
@bind xnf NumberField(0:100, default=20)

# ╔═╡ b03d72be-dd76-4fc1-83ca-af041d3322cc
md" Your number field is $xnf"

# ╔═╡ 4aeed70b-73c9-4118-aafd-55e2c714896b
md"### A Text field"

# ╔═╡ f522f5ec-f4fa-4b0e-89ac-e2a8a5a027b4
@bind s TextField()

# ╔═╡ 261fc14a-6d0b-4d84-9841-1192f6ca9e3c
md" Your number field is $s"

# ╔═╡ 44b2f35a-1f47-415e-9066-5c2b8bb10f9c
md"### A check box"

# ╔═╡ 2f680d11-71ca-4232-9074-7643284b4b17
@bind cb CheckBox(default=true)

# ╔═╡ 0ca3f7be-0979-4993-bc36-3a5d73a3c580
md" The value of your check box is $cb"

# ╔═╡ 0f643ba3-cd7d-4096-857a-a97838e760f2
md"### Select"

# ╔═╡ d2f4ce05-1a96-4177-9170-4cb1a22ab2bf
@bind futbol Select(["Real Madrid", "Barça"])

# ╔═╡ 7ac02d39-759d-446e-b7ba-09b69ba9ef48
md" Your favourite soccer team is $futbol"

# ╔═╡ 0a56c5e0-7a0a-48e3-bd47-92614227fffa
md"### Button"

# ╔═╡ 2dcdee28-199e-4e76-b774-4b39a69b7043
@bind go Button("Trigger")

# ╔═╡ ad90f827-752b-4584-b5f3-dc7bd258e9b6
md" State of Button = $go"

# ╔═╡ b9458bd0-64f3-4bd4-96f5-705ab87ed0fe
md"### Button as a reactive trigger

Try clicking several times in `Trigger`
"

# ╔═╡ 7207081f-1fac-4cb0-a15e-8cadb9f34d21
let
	go
	
	md" Only $(rand(1:15)) minutes left to midnight!"
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
InteractiveUtils = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
Markdown = "d6f4376e-aef5-505a-96c1-9c027394607a"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[compat]
PlutoUI = "~0.7.37"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.1"
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
git-tree-sha1 = "85b5da0fa43588c75bb1ff986493443f821c70b7"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.3"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "bf0a1121af131d9974241ba53f601211e9303a9e"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.37"

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
# ╠═847a880f-d8ea-44c8-af9e-dd716a806381
# ╠═0c448718-8c3d-462b-8a6c-8e28d17849c5
# ╠═e8fae5a2-3386-445c-8be4-bd3b9f151977
# ╟─b129ba7c-953a-11ea-3379-17adae34924c
# ╟─b267cd55-009e-4da2-832b-1e98dfdd2759
# ╠═d2713ff7-41a9-4c67-ba28-99f29687fab1
# ╠═a7068203-02ac-40a1-ac35-c78f4ab20cb6
# ╟─d593ca03-3504-4f3f-bd96-15d949f8824c
# ╠═3bc3a5fc-2ed7-4894-b9ad-6e3e8b50f382
# ╟─952d4797-dd4c-46a0-b54a-d72de23dca17
# ╠═1aeffd56-06e8-4c69-84ee-d70894a79861
# ╟─3150bf1a-9555-11ea-306f-0fd4d9229a51
# ╠═f2c79746-9554-11ea-39ca-298fd09248ad
# ╠═9cbb36e1-61bd-4439-9f18-58e466f2cc79
# ╟─3e5a0d51-a849-42f0-9a2c-b8e1a5d2a15e
# ╟─85f7a276-e13f-4bf1-a908-fca032894a16
# ╟─b3f3cec1-dc46-4bba-becc-bedba8b057f9
# ╟─7a89f893-b605-47a6-8f17-ab4f57ce49ef
# ╟─0e42e132-94cc-48c2-aaf7-ef81c2075f16
# ╟─f843be72-64de-427e-a3bf-202ce217f517
# ╟─1443687f-0052-49ca-a9d2-746dcf78763b
# ╟─3dca2d86-45d2-4b75-9511-8a1a6f943c4e
# ╟─a42c49a7-ccf7-4867-a3d4-0f9dcc33f9ed
# ╟─255a6968-f4c4-4991-a789-5d926ccc0f6f
# ╟─04c43494-30a0-4803-a4a0-3456cd30d93b
# ╟─789901e3-11ce-4626-aa75-9f4b8d4a574d
# ╟─b03d72be-dd76-4fc1-83ca-af041d3322cc
# ╟─4aeed70b-73c9-4118-aafd-55e2c714896b
# ╟─f522f5ec-f4fa-4b0e-89ac-e2a8a5a027b4
# ╟─261fc14a-6d0b-4d84-9841-1192f6ca9e3c
# ╟─44b2f35a-1f47-415e-9066-5c2b8bb10f9c
# ╟─2f680d11-71ca-4232-9074-7643284b4b17
# ╟─0ca3f7be-0979-4993-bc36-3a5d73a3c580
# ╟─0f643ba3-cd7d-4096-857a-a97838e760f2
# ╟─d2f4ce05-1a96-4177-9170-4cb1a22ab2bf
# ╟─7ac02d39-759d-446e-b7ba-09b69ba9ef48
# ╟─0a56c5e0-7a0a-48e3-bd47-92614227fffa
# ╠═2dcdee28-199e-4e76-b774-4b39a69b7043
# ╠═ad90f827-752b-4584-b5f3-dc7bd258e9b6
# ╟─b9458bd0-64f3-4bd4-96f5-705ab87ed0fe
# ╟─7207081f-1fac-4cb0-a15e-8cadb9f34d21
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
