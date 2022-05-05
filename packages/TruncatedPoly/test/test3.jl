using Test, TruncatedPoly

p(x) = 1.0+2*x+5*x^3

@testset "Re-expanding Series" begin
    s1 = Series((12.0, 1.0, 0.0, 0.0))
    s2 = p(s1)

    @test isapprox(p(9.0), s2(-3.0))
end