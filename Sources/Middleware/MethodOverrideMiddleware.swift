//
//  MethodOverrideMiddleware.swift
//  vapor-method-override-middleware
//
//  Created by Tomohiro Teranishi on 2017/08/10.
//
// porting from Rack::MethodOverride
// https://github.com/rack/rack/blob/master/lib/rack/method_override.rb

import Vapor
import HTTP

public class MethodOverrideMiddleware: Middleware {
    
    
    let HTTP_METHODS: [String] = ["GET","HEAD","PUT","POST","DELETE","OPTIONS","PATCH","LINK","UNLINK"];
    let METHOD_OVERRIDE_PARAM_KEY = "_method";
  //  let HTTP_METHOD_OVERRIDE_HEADER = "HTTP_X_HTTP_METHOD_OVERRIDE";
    let ALLOWED_METHODS : [String] = ["POST"];
    

    public func respond(to request: Request, chainingTo next: Responder) throws -> Response {

        // execute this logic only when allowed method called.
        if ( allowedMethods().contains(request.method.description) ) {

            let method = methodOverride(request)
            
            if ( method != nil && HTTP_METHODS.contains(method!) ){
                request.method = Method(method!);
            
            }
        }
    
      return try next.respond(to: request)
    }
    
    
    public func allowedMethods () -> [String] {
        return ALLOWED_METHODS;
    }
    
    public func methodOverride(_ request: Request) -> String? {
        let method : String? = (methodOverrideParam(request) != nil) ?
            methodOverrideParam(request) :
            request.headers["HTTP_METHOD_OVERRIDE_HEADER"]
        ;
        return method?.uppercased();
        
    }
    
    public func methodOverrideParam(_ request: Request) -> String? {
        return request.data[METHOD_OVERRIDE_PARAM_KEY]?.string;
    }
    

}
