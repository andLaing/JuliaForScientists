### A Pluto.jl notebook ###
# v0.17.5

using Markdown
using InteractiveUtils

# ╔═╡ 9a0e31e6-b40f-4c17-9a11-347d079ae854
using PlutoUI, BenchmarkTools

# ╔═╡ 55181722-c7bf-11ec-060f-4b3e16201f3e
md"# Truncated polynomials

For some strange reason, we are interested in polynomials truncated up to some order. The order is fixed beforehand. For example, if we fix the order to 4, we have
```math 
p_1(x) = 1+x^2;\quad p_2(x) = x^4+x \Longrightarrow p_1*p_2 = x+x^3+x^4+...
```
where the $$...$$ means that we are truncating the Polynomials, and we ignore all terms with powers higher than 4.

We need a data structure to work with this \"truncated polynomials\". Moreover, imagine that we are in a setup where running time is crucial: For the first time we really will worry about performance!

A natural try is to define your type with a vector inside for the values of the coefficients.
"

# ╔═╡ b832469a-d2a0-4468-b6b5-1d9e40775090
struct Series1
	c::Vector{Float64}
end

# ╔═╡ d47e7c7a-4418-4826-9744-3c23e7ab6b3a
md"Now we want to be able to operate with this truncated polynomials. Let's define the multiplication"

# ╔═╡ 83ed048f-e4f8-4499-b226-afb4b5ca1cf7
md"Ok! It seems to work. Let's get some time information"

# ╔═╡ 7a374b7d-e73e-4d1d-b71f-6ce9ce892fd1
begin 
	@benchmark Series1([1.0,0.0,1.0,0.0,0.0]) * Series1([0.0,1.0,0.0,0.0,1.0])
end	

# ╔═╡ 05c7fbe1-102e-4685-b1e4-5dad46e8a1c0
md"One problem with this in terms of efficiency is that it allocates memory!. This is because the structure contains not only values, but also pointers (to store the vector of components). This can be checked by asking julia"

# ╔═╡ 0c5fcd8e-ec5c-46ad-8c52-daf024d2de24
isbitstype(Series1)

# ╔═╡ c345de84-a3dc-445b-9b78-b604f1788319
md"Types that contains **only** values are much faster: they are \"stack allocated\"."

# ╔═╡ 88ed6676-cda5-457a-b1c9-802c86c04253
let
	x = (1.0,2.0,3.0,4.0)
	with_terminal() do
		println(typeof(x))
		println(isbits(x))
	end
end

# ╔═╡ 7b82d451-7e86-4e31-a212-0b24887182fb
md" On the other hand I cannot change its values"

# ╔═╡ 3a130919-3170-48c5-8e47-6a6976fd8375
let 
	x = (1.0,2.0,3.0,4.0)
	x[1] = 5.6
end

# ╔═╡ 739a6a24-c54e-4bc4-938a-dd0efbe0e59c
md"Once they are created, they should stay as they are. If you can live with this condition, they are usually much faster!"

# ╔═╡ 5e624148-b79c-476b-ac26-1c7024f4510e
struct Series2{T,N}
	c::NTuple{N,T}
end

# ╔═╡ b707ee1f-ca89-4579-a98e-c36a9004817e
begin
	function Base.:*(s1::Series2{T,N}, s2::Series2{T,N}) where {T,N}

	    @inline function mul(i)
    	    c = s1.c[1]*s2.c[i]
        	@inbounds for k in 2:i
            	c = c + s1.c[k]*s2.c[i-k+1]
        	end
        	return c
    	end
    
	    return Series2(ntuple(mul, N))
	end

	function Base.:+(s1::Series2{T,N}, s2::Series2{T,N}) where {T,N} 
		return Series2(ntuple(i -> s1.c[i]+s2.c[i], N))
	end
end

# ╔═╡ acfd727a-c9ce-4125-9d7a-0d3c74c245fd
begin
	import Base.:*, Base.:+
	function *(s1::Series1, s2::Series1)
		
		v = similar(s1.c)
		@inbounds for i in 1:length(v)
			v[i] = s1.c[1]*s2.c[i]
			@inbounds for k in 2:i
				v[i] = v[i] + s1.c[k]*s2.c[i-k+1]
			end
		end

		return Series1(v)
	end

	function +(s1::Series1, s2::Series1)

		v = similar(s1.c) # v = zeros(length(s1.c))
		v .= s1.c .+ s2.c
		return Series1(v)
	end
end				

# ╔═╡ d52ac33d-5f7f-4920-8461-8fe7b0e68126
let 
	s1 = Series1([1.0,0.0,1.0,0.0,0.0])
	s2 = Series1([0.0,1.0,0.0,0.0,1.0])
	s = s1*s2

	with_terminal() do
		println("s1    = ", s1)
		println("s2    = ", s2)
		println("s1*s2 = ", s)
	end
end	

# ╔═╡ da883b1d-e4da-4645-b446-b914889bac43
begin 
	@benchmark Series2((1.0,0.0,1.0,0.0,0.0)) * Series2((0.0,1.0,0.0,0.0,1.0))
end	

# ╔═╡ e25bdcb9-ab05-48bd-b572-a122e9d25521
md"Guau! 10x faster!!"

# ╔═╡ 8dfc289c-216b-4525-bb44-4af855d0842f
md"Another test:"

# ╔═╡ ad44e621-7ee2-438a-a2bc-23a49fafcf76
f(x, y) = x*y + (x+y)*(x*y) + x*x + y*y

# ╔═╡ 7381d786-4aaa-4f73-9ddc-c49c0a6481e8
@benchmark f(Series2((1.0,0.0,1.0,0.0,0.0)), Series2((0.0,1.0,0.0,0.0,1.0)))

# ╔═╡ 769e6125-5e70-4b1a-b5bc-1362c536fce0
@benchmark f(Series1([1.0,0.0,1.0,0.0,0.0]), Series1([0.0,1.0,0.0,0.0,1.0]))

# ╔═╡ c537a6f0-b6a0-46a2-b155-02d36ad2c703
md"Now we need to code all basic operations for this \"truncated Polynomials\". Let's go to `vscode`/your\_favourite\_editor"

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
BenchmarkTools = "~1.3.1"
PlutoUI = "~0.7.38"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "4c10eee4af024676200bc7752e536f858c6b8f93"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.3.1"

[[ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "1285416549ccfcdf0c50d4997a94331e88d68413"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.3.1"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "670e559e5c8e191ded66fa9ea89c97f10376bb4c"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.38"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═9a0e31e6-b40f-4c17-9a11-347d079ae854
# ╟─55181722-c7bf-11ec-060f-4b3e16201f3e
# ╠═b832469a-d2a0-4468-b6b5-1d9e40775090
# ╟─d47e7c7a-4418-4826-9744-3c23e7ab6b3a
# ╠═acfd727a-c9ce-4125-9d7a-0d3c74c245fd
# ╠═d52ac33d-5f7f-4920-8461-8fe7b0e68126
# ╠═83ed048f-e4f8-4499-b226-afb4b5ca1cf7
# ╠═7a374b7d-e73e-4d1d-b71f-6ce9ce892fd1
# ╠═05c7fbe1-102e-4685-b1e4-5dad46e8a1c0
# ╠═0c5fcd8e-ec5c-46ad-8c52-daf024d2de24
# ╟─c345de84-a3dc-445b-9b78-b604f1788319
# ╠═88ed6676-cda5-457a-b1c9-802c86c04253
# ╟─7b82d451-7e86-4e31-a212-0b24887182fb
# ╠═3a130919-3170-48c5-8e47-6a6976fd8375
# ╠═739a6a24-c54e-4bc4-938a-dd0efbe0e59c
# ╠═5e624148-b79c-476b-ac26-1c7024f4510e
# ╠═b707ee1f-ca89-4579-a98e-c36a9004817e
# ╠═da883b1d-e4da-4645-b446-b914889bac43
# ╟─e25bdcb9-ab05-48bd-b572-a122e9d25521
# ╠═8dfc289c-216b-4525-bb44-4af855d0842f
# ╠═ad44e621-7ee2-438a-a2bc-23a49fafcf76
# ╠═7381d786-4aaa-4f73-9ddc-c49c0a6481e8
# ╠═769e6125-5e70-4b1a-b5bc-1362c536fce0
# ╠═c537a6f0-b6a0-46a2-b155-02d36ad2c703
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
