
import Base.:+, Base.:-, Base.:*, Base.:/, Base.:^

Base.:+(s1::Series{T,N})                  where {T,N} = s1
Base.:+(s1::Series{T,N}, s2::Series{T,N}) where {T,N} = Series{T,N}(ntuple(i -> s1.c[i] + s2.c[i], N))
Base.:+(s1::Series{T,N}, s2::Number)      where {T,N} = Series{T,N}(ntuple(i -> i == 1 ? s1.c[1] + s2 : s1.c[i], N))
Base.:+(s2::Number, s1::Series{T,N})      where {T,N} = Series{T,N}(ntuple(i -> i == 1 ? s1.c[1] + s2 : s1.c[i], N))

Base.:-(s1::Series{T,N})                  where {T,N} = Series{T,N}(ntuple(i -> -s1.c[i], N))
Base.:-(s1::Series{T,N}, s2::Series{T,N}) where {T,N} = Series{T,N}(ntuple(i -> s1.c[i] - s2.c[i], N))
Base.:-(s1::Series{T,N}, s2::Number)      where {T,N} = Series{T,N}(ntuple(i -> i == 1 ?  s1.c[1] - s2 :  s1.c[i], N))
Base.:-(s2::Number, s1::Series{T,N})      where {T,N} = Series{T,N}(ntuple(i -> i == 1 ? -s1.c[1] + s2 : -s1.c[i], N))

function Base.:*(s1::Series{T,N}, s2::Series{T,N}) where {T,N}

    @inline function mul(i)
        c = s1.c[1]*s2.c[i]
        @inbounds for k in 2:i
            c = c + s1.c[k]*s2.c[i-k+1]
        end
        return c
    end
    
    return Series(ntuple(mul, N))
end
Base.:*(s1::Series{T,N}, s2::Number)      where {T,N} = Series{T,N}(ntuple(i -> s1.c[i]*s2, N))
Base.:*(s2::Number, s1::Series{T,N})      where {T,N} = Series{T,N}(ntuple(i -> s2*s1.c[i], N))

# For the ratio is more efficient to use generated functions. But a 
# simple alternative would be:
#function Base.:/(s1::Series{T,N}, s2::Series{T,N}) where {T,N}
#
#    @inline function div(i)
#        if i == 1
#            return s1.c[1]/s2.c[1]
#        else
#            c = s1.c[i]
#            @inbounds for k in 2:i
#                c = c - s2.c[k]*div(i-k+1)
#            end
#            c = c/s2.c[1]
#        end
#        return c
#    end    
#    
#    return Series(ntuple(div, N))

@generated function Base.:/(b::Series{T,N},a::Series{T,N}) where {T,N} 
    vars = Vector{Expr}(undef, N)
    expr = Expr(:call,:(/),:(b.c[1]),:(a.c[1]))
    vars[1] = :($(Symbol("c_1")) = $expr)
    for i in 2:N
	ex = Expr(
	    :call,
	    :+,
	    [:( a.c[$i-$k+1] * $(Symbol("c_$(k)")) ) for k in 1:i-1]...
	        )
        
        ex2 = Expr(:call, :-, :(b.c[$i]), ex)
        ex3 = Expr(:call, :/, ex2, :(a.c[1]))

	vars[i] = :($(Symbol("c_$(i)")) = $ex3)
    end

    t = Expr(:tuple,  [Symbol("c_$(i)") for i = 1:N]...)
    pack = :(Series{T, N}($t))


    return Expr(
	:block,
	vars...,
	:(return $pack)
    )
end

Base.:/(s1::Series{T,N}, s2::Number)      where {T,N} = Series{T,N}(ntuple(i -> s1.c[i]/s2, N))
@generated function Base.:/(b::Number,a::Series{T,N}) where {T,N} 
    vars = Vector{Expr}(undef, N)
    expr = Expr(:call,:(/),:(b),:(a.c[1]))
    vars[1] = :($(Symbol("c_1")) = $expr)
    for i in 2:N
	ex = Expr(
	    :call,
	    :+,
	    [:( a.c[$i-$k+1] * $(Symbol("c_$(k)")) ) for k in 1:i-1]...
	        )
        
        ex2 = Expr(:call, :-, ex)
        ex3 = Expr(:call, :/, ex2, :(a.c[1]))

	vars[i] = :($(Symbol("c_$(i)")) = $ex3)
    end

    t = Expr(:tuple,  [Symbol("c_$(i)") for i = 1:N]...)
    pack = :(Series{T, N}($t))


    return Expr(
	:block,
	vars...,
	:(return $pack)
    )
end

function Base.:^(s::Series{T,N}, n::Int) where {T,N}

    sp = s
    np = n
    r = Series(ntuple(i -> i == 1 ? one(T) : zero(T), N))
    while true
        if mod(np, 2) == 1
            r = r*sp
        end

        np = div(np, 2)
        if np == 0
            break
        end
        sp = sp*sp
    end
    return r
end
