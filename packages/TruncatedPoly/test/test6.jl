using Test, TruncatedPoly

s = Series(tuple(rand(7)...))

sl = log(s)
se = exp(sl)

@testset "e^(log(s)) = s" begin
    ok = true
    for i in 1:7
        ok = ok && isapprox(se.c[i], s.c[i])
    end
    @test ok
end