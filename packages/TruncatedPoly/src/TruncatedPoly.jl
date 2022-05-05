module TruncatedPoly

"""
    Series{T,N}

Series of type `T` up to order `N`
"""
struct Series{T,N}
    c::NTuple{N,T}
end
export Series

import Base.one, Base.zero
zero(::Type{Series{T,N}}) where {T,N} = Series{T,N}(ntuple(i-> zero(T),N))
one(::Type{Series{T,N}})  where {T,N} = Series{T,N}(ntuple(i-> i==1 ? one(T) : zero(T),N))
zero(s::Series{T,N}) where {T,N} = Series{T,N}(ntuple(i-> zero(T),N))
one(s::Series{T,N})  where {T,N} = Series{T,N}(ntuple(i-> i==1 ? one(T) : zero(T),N))

# Let's teach Julia how to evaluate a series at a point
function (s::Series{T,N})(x) where {T,N}
    
    v = s.c[N]*x + s.c[N-1]
    for k in N-2:-1:1
        v = v*x + s.c[k]
    end

    return v
end 


include("TPMath.jl")
include("TPFunctions.jl")
export sin, cos, exp, log, sqrt, abs

end # module
