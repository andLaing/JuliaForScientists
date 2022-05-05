### A Pluto.jl notebook ###
# v0.17.5

using Markdown
using InteractiveUtils

# ╔═╡ 3d28128c-d437-403b-94ed-46fd8b32b651
import Pkg

# ╔═╡ 88f1f82f-fd58-4c2e-b0cd-69627d141a26
Pkg.develop(url="../../packages/MixedUtils")

# ╔═╡ ff62567c-c863-4c02-a35b-08267c31e73a
Pkg.develop(url="../../packages/TruncatedPoly")

# ╔═╡ 54fa5408-c86b-11ec-0a02-8d5c86cc7868
using PlutoUI, Plots, Random, BenchmarkTools

# ╔═╡ 55c9b14d-08f1-4383-be17-4c11f9af50a2
using MixedUtils

# ╔═╡ f3a4eef2-b925-462f-aa86-61eb2f63654b
using TruncatedPoly

# ╔═╡ 49a38c64-5cbb-4f19-b682-d177c306ada2
md"# More about truncated polynomials

In what sense are truncated polynomials useful? Well, the usefullness must come from where this is a mathematically sound concept. The fact that we discard higher powers $$x^n\, (n>N)$$ with respect to a normal polynomial multiplication is only mathematically sound if we can interpret the variable $$x$$ as small.

If we have a function $$f(a + x)$$, and $$x$$ is small, we can use its Taylor approximation
```math
f(a+x) = f(a) + f'(a)x + \frac{f''(a)}{2} x^2 + ...
```
This automatically imply **that if we exaluate $$f(x)$$ with the series $$x = (a,1,0,0,...)$$** we will get its Taylor expansion!!. Let's make a few examples!
"

# ╔═╡ 1826138c-b049-4439-b237-04874ba93fb2
let 
	f(x) = (1+2*x+4*x^2-4*x^5)/(2+x^2+x^4)
	s = Series((2.0,1.0,0.0,0.0,0.0,0.0,0.0)) # Taylor series around x=2.0
	ftaylor = f(s)

	xv = collect(-1.0:0.05:5.0)
	fv = f.(xv)
	sv = ftaylor.(xv.-2.0)
	plot(xv,fv,label="Function",seriestype=:scatter, ylims=(-20,2))
	plot!(xv,sv,label="Taylor O(6)", lw=3)
end

# ╔═╡ 0c7e7124-6a46-4ae5-a135-d269aaec5c55
md"Note that we have a method to compute derivatives **exactly** (i.e. to machine precision):"

# ╔═╡ eff98c5d-6c48-413c-a287-7ee0ece23fb0
let
	f(x) = sin(x^2+0.5)*(x^2+3)/(exp(x + log(x^2)) + 2*x + 1)
	s = Series((2.0, 1.0, 0.0,0.0,0.0,0.0,0.0,0.0))
	fs = f(s)
	with_terminal() do
		println("Value of the function at x=2.0: ", fs.c[1])
		for i in 2:length(s.c)
			println("  - Derivative of order ", i, " is:", fs.c[i]*factorial(i-1))
		end
	end
	
end

# ╔═╡ 0422eee0-70dc-4fee-9118-729dec3b95e5
md"Let's check this one again"

# ╔═╡ 7d25e9bb-cb13-4b1f-b30f-118a08a78e4c
let 
	f(x) = sin(x^2+0.5)*(x^2+3)/(exp(x + log(x^2)) + 2*x + 1)
	s = Series((2.0,1.0,0.0,0.0,0.0,0.0,0.0)) # Taylor series around x=2.0
	ftaylor = f(s)

	xv = collect(1.0:0.05:3)
	fv = f.(xv)
	sv = ftaylor.(xv.-2.0)
	plot(xv,fv,label="Function",seriestype=:scatter)
	plot!(xv,sv,label="Taylor O(6)", lw=3)
end

# ╔═╡ ba24a3ab-864b-40a7-adc4-db90db2dcebb
md"Now we can code a useful addition to our old `newton` method: We can compute the derivatives automatically!"

# ╔═╡ bf6af621-16ad-48ab-86cc-86de97cf71b0
"""
	add_der(f)

Given a function `f`, this routine returns **another** function that returns a `Tuple` with the values of the functions and its first derivative
"""
function add_der(f)
	function der(f, x)
    	xs = Series((x, one(x)))
        fv = f(xs)
    	return fv.c[1], fv.c[2]
    end

	return x -> der(f, x)
end

# ╔═╡ 70e398d5-acd7-4ffa-98cf-c9701c17dbe8
let 
	f(x) = x^2+4
	fd = add_der(f)
	fd(1.0)
end

# ╔═╡ bdc0f545-99fd-49bb-ad41-3703bc020235
md"Perfect! This can be used with `newton`!"

# ╔═╡ 63810ce3-1459-49ab-bfba-24dd41e9830f
let 
	f(x) = sin(x)*x^2 - 3*x*cos(exp(x+2.0) + x^2) - log(x*exp(x)) - 2.4
	root = newton(add_der(f), 0.36)
end

# ╔═╡ 5813151e-a727-4037-8a07-a3aa33423b4f
md"It work for complex arguments!"

# ╔═╡ 94ce599b-c895-479b-8dc3-e04b53ac1fac
let 
	f(x) = x^3-1.0
	newton(add_der(f), complex(-2.34, 1.23))
end

# ╔═╡ 2f0d03ec-9bf0-47c6-85ae-db91367cb78c
md"## Differential programming

We have argued that we can compute the Taylor series of any function. But this include even iterative complicated functions! For example, let's recall our example of the newton method
"

# ╔═╡ 477ea374-b9a0-409d-a2f6-40cd63f1e1c1
fparameter(x, a) = a*cos(x)-x, -a*sin(x)-1.0

# ╔═╡ 5681865c-ace1-460f-80a0-4af6f12c1898
md"And let's define a function that returns the root of $$a\cos x - x$$ as a function of $$a$$"

# ╔═╡ f08a3dee-0c34-493c-a166-40b7256ca988
froot(a) = newton(x -> fparameter(x, a), 1.0)[1]

# ╔═╡ 7a3ffff4-60d5-4525-a28d-e4c55e871dd6
froot.(collect(1.2:0.1:1.8))

# ╔═╡ af4aab94-faf9-4f35-afd1-2d827f31d7ba
let 
	s = Series((1.5,1.0,0.0,0.0,0.0,0.0,0.0)) # Taylor series around x=2.0
	ftaylor = froot(s)

	xv = collect(-1.0:0.05:6)
	fv = froot.(xv)
	sv = ftaylor.(xv.-1.5)
	plot(xv,fv,label="Function",seriestype=:scatter, legend=:bottom)
	plot!(xv,sv,label="Taylor O(6)", lw=3)
end

# ╔═╡ 9bd645f1-610a-4641-ad79-0a14d8c2daca
md"We have computed the Taylor expansion of the program \"Determine the root of $$a\cos x - x$$\" with respect to $$a$$!! "

# ╔═╡ 2ab26108-e4ac-4442-b8e6-c0fd51791caa
md"By the way... Let's Benchmark this:"

# ╔═╡ ddbf00c1-a258-486d-afcb-850dc238995a
@benchmark ftaylor = froot(Series((1.5,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0)))

# ╔═╡ a1517780-2766-4432-9d69-116f7726d60e
let 
	@benchmark newton(add_der(x -> sin(x)*x^2 - 3*x*cos(exp(x+2.0) + x^2) - log(x*exp(x)) - 2.4), complex(-2.34, 1.23))
end

# ╔═╡ 465d5bc0-7e8e-49b4-b097-e5eed1265469
md"**ZERO** allocations in finding the Taylor series!, **ZERO** allocations in adding the exact derivative!"

# ╔═╡ Cell order:
# ╠═54fa5408-c86b-11ec-0a02-8d5c86cc7868
# ╠═3d28128c-d437-403b-94ed-46fd8b32b651
# ╠═88f1f82f-fd58-4c2e-b0cd-69627d141a26
# ╠═55c9b14d-08f1-4383-be17-4c11f9af50a2
# ╠═ff62567c-c863-4c02-a35b-08267c31e73a
# ╠═f3a4eef2-b925-462f-aa86-61eb2f63654b
# ╟─49a38c64-5cbb-4f19-b682-d177c306ada2
# ╠═1826138c-b049-4439-b237-04874ba93fb2
# ╟─0c7e7124-6a46-4ae5-a135-d269aaec5c55
# ╠═eff98c5d-6c48-413c-a287-7ee0ece23fb0
# ╠═0422eee0-70dc-4fee-9118-729dec3b95e5
# ╠═7d25e9bb-cb13-4b1f-b30f-118a08a78e4c
# ╠═ba24a3ab-864b-40a7-adc4-db90db2dcebb
# ╠═bf6af621-16ad-48ab-86cc-86de97cf71b0
# ╠═70e398d5-acd7-4ffa-98cf-c9701c17dbe8
# ╠═bdc0f545-99fd-49bb-ad41-3703bc020235
# ╠═63810ce3-1459-49ab-bfba-24dd41e9830f
# ╠═5813151e-a727-4037-8a07-a3aa33423b4f
# ╠═94ce599b-c895-479b-8dc3-e04b53ac1fac
# ╟─2f0d03ec-9bf0-47c6-85ae-db91367cb78c
# ╠═477ea374-b9a0-409d-a2f6-40cd63f1e1c1
# ╠═5681865c-ace1-460f-80a0-4af6f12c1898
# ╠═f08a3dee-0c34-493c-a166-40b7256ca988
# ╠═7a3ffff4-60d5-4525-a28d-e4c55e871dd6
# ╠═af4aab94-faf9-4f35-afd1-2d827f31d7ba
# ╟─9bd645f1-610a-4641-ad79-0a14d8c2daca
# ╟─2ab26108-e4ac-4442-b8e6-c0fd51791caa
# ╠═ddbf00c1-a258-486d-afcb-850dc238995a
# ╠═a1517780-2766-4432-9d69-116f7726d60e
# ╠═465d5bc0-7e8e-49b4-b097-e5eed1265469
