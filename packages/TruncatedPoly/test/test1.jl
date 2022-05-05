
using Test, TruncatedPoly

s1 = Series((1.0,0.0,2.0,0.0))
s2 = Series((0.0,1.0,0.0,1.0))

@testset "Testing basic oprations" begin
    s = s1+s2
    @test (s.c[1] == s1.c[1]+s2.c[1]) && (s.c[2] == s1.c[2]+s2.c[2]) && (s.c[3] == s1.c[3]+s2.c[3]) && (s.c[4] == s1.c[4]+s2.c[4])
    
    s = s1-s2
    @test (s.c[1] == s1.c[1]-s2.c[1]) && (s.c[2] == s1.c[2]-s2.c[2]) && (s.c[3] == s1.c[3]-s2.c[3]) && (s.c[4] == s1.c[4]-s2.c[4])
    
    s = s1+3.0
    @test (s.c[1] == s1.c[1]+3.0) && (s.c[2] == s1.c[2]) && (s.c[3] == s1.c[3]) && (s.c[4] == s1.c[4])
    
    s = s1-3.0
    @test (s.c[1] == s1.c[1]-3.0) && (s.c[2] == s1.c[2]) && (s.c[3] == s1.c[3]) && (s.c[4] == s1.c[4])
end
