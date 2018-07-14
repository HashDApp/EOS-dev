
# 合约文件的预处理

使用g++的-E选择保存编译的预处理结果  
看看合约文件是如何展开的  

```
cd mycontracts/hello
g++ -std=c++14 -E -I ~/opt/boost/include hello.cpp > hello.i
tail -n 200 hello.i
```

预处理的文件有10几万行  
这里只截取最后200行  
```
};

}


template<class T, T N> using make_integer_sequence = typename detail::make_integer_sequence_impl<T, N>::type;


template<std::size_t... I> using index_sequence = integer_sequence<std::size_t, I...>;


template<std::size_t N> using make_index_sequence = make_integer_sequence<std::size_t, N>;


template<class... T> using index_sequence_for = make_integer_sequence<std::size_t, sizeof...(T)>;

}
}
# 12 "/root/opt/boost/include/boost/mp11/tuple.hpp" 2 3
# 24 "/root/opt/boost/include/boost/mp11/tuple.hpp" 3
namespace boost
{
namespace mp11
{


namespace detail
{

template<class F, class Tp, std::size_t... J> constexpr auto tuple_apply_impl( F && f, Tp && tp, integer_sequence<std::size_t, J...> )
    -> decltype( std::forward<F>(f)( std::get<J>(std::forward<Tp>(tp))... ) )
{
    return std::forward<F>(f)( std::get<J>(std::forward<Tp>(tp))... );
}

}

template<class F, class Tp,
    class Seq = make_index_sequence<std::tuple_size<typename std::remove_reference<Tp>::type>::value>>
constexpr auto tuple_apply( F && f, Tp && tp )
    -> decltype( detail::tuple_apply_impl( std::forward<F>(f), std::forward<Tp>(tp), Seq() ) )
{
    return detail::tuple_apply_impl( std::forward<F>(f), std::forward<Tp>(tp), Seq() );
}


namespace detail
{

template<class T, class Tp, std::size_t... J> constexpr T construct_from_tuple_impl( Tp && tp, integer_sequence<std::size_t, J...> )
{
    return T( std::get<J>(std::forward<Tp>(tp))... );
}

}

template<class T, class Tp,
    class Seq = make_index_sequence<std::tuple_size<typename std::remove_reference<Tp>::type>::value>>
constexpr T construct_from_tuple( Tp && tp )
{
    return detail::construct_from_tuple_impl<T>( std::forward<Tp>(tp), Seq() );
}


namespace detail
{

template<class Tp, std::size_t... J, class F> constexpr F tuple_for_each_impl( Tp && tp, integer_sequence<std::size_t, J...>, F && f )
{
    using A = int[sizeof...(J)];
    return (void)A{ ((void)f(std::get<J>(std::forward<Tp>(tp))), 0)... }, std::forward<F>(f);
}

template<class Tp, class F> constexpr F tuple_for_each_impl( Tp && , integer_sequence<std::size_t>, F && f )
{
    return std::forward<F>(f);
}

}

template<class Tp, class F> constexpr F tuple_for_each( Tp && tp, F && f )
{
    using seq = make_index_sequence<std::tuple_size<typename std::remove_reference<Tp>::type>::value>;
    return detail::tuple_for_each_impl( std::forward<Tp>(tp), seq(), std::forward<F>(f) );
}

}
}
# 9 "/usr/local/include/eosiolib/dispatcher.hpp" 2 3

namespace eosio {
   template<typename Contract, typename FirstAction>
   bool dispatch( uint64_t code, uint64_t act ) {
      if( code == FirstAction::get_account() && FirstAction::get_name() == act ) {
         Contract().on( unpack_action_data<FirstAction>() );
         return true;
      }
      return false;
   }
# 31 "/usr/local/include/eosiolib/dispatcher.hpp" 3
   template<typename Contract, typename FirstAction, typename SecondAction, typename... Actions>
   bool dispatch( uint64_t code, uint64_t act ) {
      if( code == FirstAction::get_account() && FirstAction::get_name() == act ) {
         Contract().on( unpack_action_data<FirstAction>() );
         return true;
      }
      return eosio::dispatch<Contract,SecondAction,Actions...>( code, act );
   }

   template<typename T, typename Q, typename... Args>
   bool execute_action( T* obj, void (Q::*func)(Args...) ) {
      size_t size = action_data_size();


      constexpr size_t max_stack_buffer_size = 512;
      void* buffer = nullptr;
      if( size > 0 ) {
         buffer = max_stack_buffer_size < size ? malloc(size) : __builtin_alloca (size);
         read_action_data( buffer, size );
      }

      auto args = unpack<std::tuple<std::decay_t<Args>...>>( (char*)buffer, size );

      if ( max_stack_buffer_size < size ) {
         free(buffer);
      }

      auto f2 = [&]( auto... a ){
         (obj->*func)( a... );
      };

      boost::mp11::tuple_apply( f2, args );
      return true;
   }
# 108 "/usr/local/include/eosiolib/dispatcher.hpp" 3
}
# 11 "/usr/local/include/eosiolib/eosio.hpp" 2 3
# 1 "/usr/local/include/eosiolib/contract.hpp" 1 3
       
```

### demo的hello合约继承自contract  

```
namespace eosio {

class contract {
   public:
      contract( account_name n ):_self(n){}

      inline account_name get_self()const { return _self; }

   protected:
      account_name _self;
};

}
# 11 "/usr/local/include/eosiolib/eosio.hpp" 2 3
# 2 "hello.cpp" 2

# 2 "hello.cpp"
using namespace eosio;

class hello : public eosio::contract {
  public:
      using contract::contract;


      void hi( account_name user ) {
         print( "Hello, ", name{user} );
      }
};

```

### EOSIO_ABI( hello, (hi) )展开的结果  

```
# 14 "hello.cpp" 3
extern "C" { void apply( uint64_t receiver, uint64_t code, uint64_t action ) { auto self = receiver; if( action == ::eosio::string_to_name(
# 14 "hello.cpp"
"onerror"
# 14 "hello.cpp" 3
)) { eosio_assert(code == ::eosio::string_to_name(
# 14 "hello.cpp"
"eosio"
# 14 "hello.cpp" 3
), "onerror action's are only valid from the \"eosio\" system account"); } if( code == self || action == ::eosio::string_to_name(
# 14 "hello.cpp"
"onerror"
# 14 "hello.cpp" 3
) ) { 
# 14 "hello.cpp"
hello 
# 14 "hello.cpp" 3
thiscontract( self ); switch( action ) { case ::eosio::string_to_name( 
# 14 "hello.cpp"
"hi" 
# 14 "hello.cpp" 3
): eosio::execute_action( &thiscontract, &
# 14 "hello.cpp"
hello
# 14 "hello.cpp" 3
::
# 14 "hello.cpp"
hi 
# 14 "hello.cpp" 3
); break; } } } }
```

