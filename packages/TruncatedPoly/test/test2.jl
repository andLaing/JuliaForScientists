
using Test, TruncatedPoly

p(x) = 1.0+2*x+5*x^3

@testset "Evaluating Series" begin
    s = Series((1.0, 2.0, 0.0, 5.0))

    @test isapprox(p(9.3),s(9.3))
end