#import <Foundation/Foundation.h>

@class PMKPromise;

/**
 *  Client interface for sending HTTP Requests
 */
@interface HttpClient : NSObject

typedef void (^SuccessRequestCallback)(id response);
typedef void (^FailureRequestCallback)(NSError *error);
typedef void (^SuccessPromiseCallback)(id responseObject, NSURLSessionDataTask *dataTask);
typedef void (^FailurePromiseCallback)(NSError *error);

#pragma mark - GET HTTP Request
/**
 *  GET HTTP Request with default headers
 *
 *  @param url       the request URL
 *  @param params    the query parameters
 *  @param successCb the success callback handler when request
 *  @param failureCb the failure callback handler when request
 */
+ (void)getWithUrl:(NSString *)url
            params:(NSDictionary *)params
           success:(SuccessRequestCallback)successCb
           failure:(FailureRequestCallback)failureCb;

/**
 *  GET HTTP Request
 *
 *  @param url       the request URL
 *  @param params    the query parameters
 *  @param headers   the request headers
 *  @param successCb the success callback handler when request
 *  @param failureCb the failure callback handler when request
 */
+ (void)getWithUrl:(NSString *)url
            params:(NSDictionary *)params
           headers:(NSDictionary *)headers
           success:(SuccessRequestCallback)successCb
           failure:(FailureRequestCallback)failureCb;

/**
 *  GET HTTP Request with default headers and return promise
 *
 *  @param url    the request URL
 *  @param params the query parameters
 *
 *  @return promise results for callback handler
 */
+ (PMKPromise *)getWithUrl:(NSString *)url
                    params:(NSDictionary *)params;

/**
 *  GET HTTP Request and return promise
 *
 *  @param url     the request URL
 *  @param params  the query parameters
 *  @param headers the requet headers
 *
 *  @return promise resutls for callback handler
 */
+ (PMKPromise *)getWithUrl:(NSString *)url
                    params:(NSDictionary *)params
                   headers:(NSDictionary *)headers;

#pragma mark - POST HTTP Request
/**
 *  POST HTTP Request with default headers
 *
 *  @param url       the request URL
 *  @param body      the body parameters
 *  @param successCb the success callback handler when request
 *  @param failureCb the failure callback handler when request
 */
+ (void)postWithUrl:(NSString *)url
               body:(NSDictionary *)body
            success:(SuccessRequestCallback)successCb
            failure:(FailureRequestCallback)failureCb;

/**
 *  POST HTTP Request
 *
 *  @param url       the request URL
 *  @param body      the body parameters
 *  @param headers   the request headers
 *  @param successCb the success callback handler when request
 *  @param failureCb the failure callback handler when request
 */
+ (void)postWithUrl:(NSString *)url
               body:(NSDictionary *)body
            headers:(NSDictionary *)headers
            success:(SuccessRequestCallback)successCb
            failure:(FailureRequestCallback)failureCb;

/**
 *  POST HTTP Request with default headers and return promises
 *
 *  @param url  the request URL
 *  @param body the body parameter
 *
 *  @return the promise results for callback handler
 */
+ (PMKPromise *)postWithUrl:(NSString *)url
                       body:(NSDictionary *)body;

/**
 *  POST HTTP Request and return promises
 *
 *  @param url     the request URL
 *  @param body    the body parameters
 *  @param headers the request headers
 *
 *  @return the promise results for callback handler
 */
+ (PMKPromise *)postWithUrl:(NSString *)url
                       body:(NSDictionary *)body
                    headers:(NSDictionary *)headers;

#pragma mark - PUT HTTP Request
/**
 *  PUT HTTP Request with default headers
 *
 *  @param url       the request URL
 *  @param body      the body parameters
 *  @param successCb the success callback handler when request
 *  @param failureCb the failure callback handler when request
 */
+ (void)putWithUrl:(NSString *)url
              body:(NSDictionary *)body
           success:(SuccessRequestCallback)successCb
           failure:(FailureRequestCallback)failureCb;

/**
 *  PUT HTTP Request
 *
 *  @param url       the request URL
 *  @param body      the body parameters
 *  @param headers   the request headers
 *  @param successCb the success callback handler when request
 *  @param failureCb the failure callback handler when request
 */
+ (void)putWithUrl:(NSString *)url
              body:(NSDictionary *)body
           headers:(NSDictionary *)headers
           success:(SuccessRequestCallback)successCb
           failure:(FailureRequestCallback)failureCb;

/**
 *  PUT HTTP Request with default headers and return promises
 *
 *  @param url  the request URL
 *  @param body the body parameters
 *
 *  @return the promise results for callback handler
 */
+ (PMKPromise *)putWithUrl:(NSString *)url body:(NSDictionary *)body;

/**
 *  PUT HTTP Request and return promises
 *
 *  @param url     the request URL
 *  @param body    the body parameters
 *  @param headers the request headers
 *
 *  @return the promise results for callback handler
 */
+ (PMKPromise *)putWithUrl:(NSString *)url body:(NSDictionary *)body headers:(NSDictionary *)headers;

#pragma mark - DELETE HTTP Request
/**
 *  DELETE HTTP Request with default headers
 *
 *  @param url       the request URL
 *  @param params    the query parameters
 *  @param successCb the success callback handler when request
 *  @param failureCb the failure callback handler when request
 */
+ (void)deleteWithUrl:(NSString *)url
               params:(NSDictionary *)params
              success:(SuccessRequestCallback)successCb
              failure:(FailureRequestCallback)failureCb;

/**
 *  DELETE HTTP Request
 *
 *  @param url       the request URL
 *  @param params    the query parameters
 *  @param headers   the request headers
 *  @param successCb the success callback handler when request
 *  @param failureCb the failure callback handler when request
 */
+ (void)deleteWithUrl:(NSString *)url
               params:(NSDictionary *)params
              headers:(NSDictionary *)headers
              success:(SuccessRequestCallback)successCb
              failure:(FailureRequestCallback)failureCb;

/**
 *  DELETE HTTP Request with default headers and return promises
 *
 *  @param url    the request URL
 *  @param params the query parameters
 *
 *  @return the promise results for callback handler
 */
+ (PMKPromise *)deleteWithUrl:(NSString *)url
                       params:(NSDictionary *)params;

/**
 *  DELETE HTTP Request and return promises
 *
 *  @param url     the request URL
 *  @param params  the query parameters
 *  @param headers the request headers
 *
 *  @return the promises results for callback handler
 */
+ (PMKPromise *)deleteWithUrl:(NSString *)url
                       params:(NSDictionary *)params
                      headers:(NSDictionary *)headers;

/**
 *  Get default promised callback handler for failed request
 *
 *  @return the promise callback
 */
+ (FailurePromiseCallback)defaultFailure;

@end
