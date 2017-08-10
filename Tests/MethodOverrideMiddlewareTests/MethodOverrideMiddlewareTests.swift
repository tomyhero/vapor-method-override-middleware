import XCTest
import Testing
import HTTP
import Sockets
@testable import Vapor
@testable import Middleware

class MethodOverrideMiddlewareTests: XCTestCase {
    
    func testMethodOverride_ParamPUT() {
        
        let m = MethodOverrideMiddleware();
        
        let req = Request.makeTest(method: .post,  query: "_method=PUT")
        let method = m.methodOverride(req)
        XCTAssertEqual("PUT", method)
        

    }
    
    func testMethodOverride_Param_lc_PUT() {
        
        let m = MethodOverrideMiddleware();
        
        let req = Request.makeTest(method: .post,  query: "_method=put")
        let method = m.methodOverride(req)
        XCTAssertEqual("PUT", method)
        
        
    }

    
    
    
    func testMethodOverride_HeaderPUT() {
        
        let m = MethodOverrideMiddleware();
        
        let req = Request.makeTest(method: .post,headers: ["HTTP_METHOD_OVERRIDE_HEADER" : "PUT"])
        let method = m.methodOverride(req)
        XCTAssertEqual("PUT", method)
        
        
    }
    
    func testMethodOverride_nil() {
        
        let m = MethodOverrideMiddleware();
        
        let req = Request.makeTest(method: .post)
        let method = m.methodOverride(req)
        XCTAssertEqual(nil, method)
        
        
    }


    func testMethodOverride_empty() {
        
        let m = MethodOverrideMiddleware();
        
        let req = Request.makeTest(method: .post,headers: ["HTTP_METHOD_OVERRIDE_HEADER" : ""])
        let method = m.methodOverride(req)
        XCTAssertEqual("", method)
        
    }
    
    
    func testMethodOverrideParam_PUT() {
        let m = MethodOverrideMiddleware();

        let req = Request.makeTest(method: .post,  query: "_method=PUT")
        let method = m.methodOverrideParam(req)
        XCTAssertEqual("PUT", method)

    }

    func testMethodOverrideParam_empty() {
        let m = MethodOverrideMiddleware();
        
        let req = Request.makeTest(method: .post,  query: "_method=")
        let method = m.methodOverrideParam(req)
        XCTAssertEqual("", method)
        
    }
    
    func testMethodOverrideParam_nil() {
        let m = MethodOverrideMiddleware();
        
        let req = Request.makeTest(method: .post)
        let method = m.methodOverrideParam(req)
        XCTAssertEqual(nil, method)
        
    }

    


    static var allTests = [
        ("testMethodOverride_ParamPUT",testMethodOverride_ParamPUT),
        ("testMethodOverride_Param_lc_PUT",testMethodOverride_Param_lc_PUT),
        ("testMethodOverride_HeaderPUT",testMethodOverride_HeaderPUT),
        ("testMethodOverride_nil",testMethodOverride_nil),
        ("testMethodOverride_empty",testMethodOverride_empty),
        ("testMethodOverrideParam_PUT",testMethodOverrideParam_PUT),
        ("testMethodOverrideParam_empty",testMethodOverrideParam_empty),
        ("testMethodOverrideParam_nil",testMethodOverrideParam_nil),
        ("testMiddlewarePUT", testMiddleware),

    ]
}



extension MethodOverrideMiddlewareTests {
    
    // Test stateless token authentication
    func testMiddleware() throws {
        var config = Config([:])
        try config.set("droplet.middleware", [
            "method-override"
            ])
        
        config.addConfigurable(middleware: { config in
            MethodOverrideMiddleware()
        }, name: "method-override")
        
        let drop = try Droplet(config)
 
        let reqOK = Request.makeTest(method: .post,query: "_method=put")
        try drop.respond(to: reqOK)
        XCTAssertEqual(reqOK.method, .put)
        
        let reqGet = Request.makeTest(method: .get,query: "_method=PUT")
        try drop.respond(to: reqGet)
        XCTAssertEqual(reqGet.method, .get)
        
        

    }
    

}

