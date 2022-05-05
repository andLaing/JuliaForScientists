using Test, TruncatedPoly

s = Series(tuple(rand(7)...))

ssin = sin(s)
scos = cos(s)
maybe1 = ssin^2 + scos^2

@testset "sin^2+cos^2 = 1" begin
    ok = isapprox(maybe1.c[1], 1.0)
    for i in 2:7
        ok = ok && isapprox(maybe1.c[i], 0.0, atol=1.0E-14, rtol=0.0)
    end
    @test ok
end