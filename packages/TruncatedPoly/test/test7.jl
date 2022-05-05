using Test, TruncatedPoly

s = Series(tuple(rand(7)...))

sl = s^2
se = sqrt(sl)

@testset "sqrt(s^2) = s" begin
    ok = true
    for i in 1:7
        ok = ok && isapprox(se.c[i], s.c[i])
    end
    @test ok
end