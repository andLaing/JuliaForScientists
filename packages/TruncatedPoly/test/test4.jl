using Test, TruncatedPoly

s1 = Series(tuple(rand(5)...))
s2 = Series(tuple(rand(5)...))

@testset "Division of series" begin
    s = s1/s2
    s = s*s2

    @test isapprox(s.c[1], s1.c[1]) && isapprox(s.c[2], s1.c[2]) && isapprox(s.c[3], s1.c[3]) && isapprox(s.c[4], s1.c[4]) && isapprox(s.c[5], s1.c[5]) 
end