var TcHmi;!function(TcHmi){!function(Functions){!function(Beckhoff){Beckhoff.Decrement=function(ctx,symbol,minValue,stepWidth){if(!ctx)throw new TypeError("Parameter 'ctx' must be defined.");if(!ctx.success||!ctx.error)throw new TypeError("Parameter 'ctx' must be defined properly. Either 'success' or 'error' or both are missing.");if("function"!=typeof ctx.success||"function"!=typeof ctx.error)throw new TypeError("Parameter 'ctx' must be defined properly. Either 'success' or 'error' or both are not of type 'function'.");null!=symbol?symbol instanceof TcHmi.Symbol?symbol.readEx((function(data){if(data.error!==TcHmi.Errors.NONE)return void ctx.error(data.error,{code:data.error,message:TcHmi.Errors[data.error],reason:"Function: Decrement, symbol value read failed",domain:"Function",errors:data.details?[data.details]:void 0});let value=TcHmi.ValueConverter.toNumber(data.value);if(null===value)return void ctx.error(TcHmi.Errors.E_PARAMETER_INVALID,{code:TcHmi.Errors.E_PARAMETER_INVALID,message:TcHmi.Errors[TcHmi.Errors.E_PARAMETER_INVALID],reason:"Function: Decrement, symbol value is no number.",domain:"Function"});let convertedStepWidth=TcHmi.ValueConverter.toNumber(stepWidth,1);isNaN(convertedStepWidth)&&(convertedStepWidth=1),value-=convertedStepWidth;const convertedMinValue=TcHmi.ValueConverter.toNumber(minValue);null===convertedMinValue||isNaN(convertedMinValue)||convertedMinValue<=value?symbol.write(value,(function(data){data.error===TcHmi.Errors.NONE?ctx.success():ctx.error(data.error,{code:data.error,message:TcHmi.Errors[data.error],reason:"Function: Decrement, symbol value write failed",domain:"Function",errors:data.details?[data.details]:void 0})})):ctx.success()})):ctx.error(TcHmi.Errors.E_PARAMETER_INVALID,{code:TcHmi.Errors.E_PARAMETER_INVALID,message:TcHmi.Errors[TcHmi.Errors.E_PARAMETER_INVALID],reason:"Function: Decrement, parameter is no symbol.",domain:"Function"}):ctx.error(TcHmi.Errors.E_PARAMETER_INVALID,{code:TcHmi.Errors.E_PARAMETER_INVALID,message:TcHmi.Errors[TcHmi.Errors.E_PARAMETER_INVALID],reason:"Function: Decrement, requested symbol is not set.",domain:"Function"})}}(Functions.Beckhoff||(Functions.Beckhoff={}))}(TcHmi.Functions||(TcHmi.Functions={}))}(TcHmi||(TcHmi={})),TcHmi.Functions.registerFunctionEx("Decrement","TcHmi.Functions.Beckhoff",TcHmi.Functions.Beckhoff.Decrement);