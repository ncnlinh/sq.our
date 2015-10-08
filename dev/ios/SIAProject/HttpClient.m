#import <AFNetworking/AFNetworking.h>
#import <PromiseKit-AFNetworking/AFNetworking+PromiseKit.h>

#import "HttpClient.h"

@implementation HttpClient

/**
 *  Get the client instance which will be used for HTTP Request
 *
 *  @return The singletion instance
 */
+ (AFHTTPSessionManager *)instance {
  static AFHTTPSessionManager *manager = nil;
  if (manager == nil) {
    manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@""]];
  }
  
  return manager;
}

/**
 *  Set request headers for the everry HTTP request of the curret client instance
 *
 *  @param headers The list of given headers
 */
+ (void)setRequestHeaders:(NSDictionary *)headers {
  AFHTTPSessionManager *managerInstance = [HttpClient instance];
  managerInstance.requestSerializer = [AFJSONRequestSerializer serializer];
  for (NSString *header in headers) {
    [managerInstance.requestSerializer setValue:[headers objectForKey:header]
                             forHTTPHeaderField:header];
  }
}

#pragma mark - GET HTTP Request
+ (void)getWithUrl:(NSString *)url
            params:(NSDictionary *)params
           success:(SuccessRequestCallback)successCb
           failure:(FailureRequestCallback)failureCb {
  [HttpClient getWithUrl:url params:params headers:nil success:successCb failure:failureCb];
}

+ (void)getWithUrl:(NSString *)url
            params:(NSDictionary *)params
           headers:(NSDictionary *)headers
           success:(SuccessRequestCallback)successCb
           failure:(FailureRequestCallback)failureCb {
  AFHTTPSessionManager *managerInstance = [HttpClient instance];
  [HttpClient setRequestHeaders:headers];
  [managerInstance GET:url
            parameters:params
               success:^(NSURLSessionDataTask *task, id responseObject) {
                 successCb(responseObject);
               }
               failure:^(NSURLSessionDataTask *task, NSError *error) {
                 failureCb(error);
               }];
}

+ (PMKPromise *)getWithUrl:(NSString *)url params:(NSDictionary *)params {
  return [HttpClient getWithUrl:url params:params headers:nil];
}

+ (PMKPromise *)getWithUrl:(NSString *)url
                    params:(NSDictionary *)params
                   headers:(NSDictionary *)headers {
  AFHTTPSessionManager *managerInstance = [HttpClient instance];
  [HttpClient setRequestHeaders:headers];
  
  return [managerInstance GET:url parameters:params];
}

#pragma mark - POST HTTP Request
+ (void)postWithUrl:(NSString *)url
               body:(NSDictionary *)body
            success:(SuccessRequestCallback)successCb
            failure:(FailureRequestCallback)failureCb {
  [HttpClient postWithUrl:url body:body headers:nil success:successCb failure:failureCb];
}

+ (void)postWithUrl:(NSString *)url
               body:(NSDictionary *)body
            headers:(NSDictionary *)headers
            success:(SuccessRequestCallback)successCb
            failure:(FailureRequestCallback)failureCb {
  AFHTTPSessionManager *managerInstance = [HttpClient instance];
  [HttpClient setRequestHeaders:headers];
  [managerInstance POST:url
             parameters:body
                success:^(NSURLSessionDataTask *task, id responseObject) {
                  successCb(responseObject);
                }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
                  failureCb(error);
                }];
}

+ (PMKPromise *)postWithUrl:(NSString *)url body:(NSDictionary *)body {
  return [HttpClient postWithUrl:url body:body headers:nil];
}

+ (PMKPromise *)postWithUrl:(NSString *)url
                       body:(NSDictionary *)body
                    headers:(NSDictionary *)headers {
  AFHTTPSessionManager *managerInstance = [HttpClient instance];
  [HttpClient setRequestHeaders:headers];
  
  return [managerInstance POST:url parameters:body];
}

#pragma mark - PUT HTTP Request
+ (void)putWithUrl:(NSString *)url
              body:(NSDictionary *)body
           success:(SuccessRequestCallback)successCb
           failure:(FailureRequestCallback)failureCb {
  [HttpClient putWithUrl:url body:body headers:nil success:successCb failure:failureCb];
}

+ (void)putWithUrl:(NSString *)url
              body:(NSDictionary *)body
           headers:(NSDictionary *)headers
           success:(SuccessRequestCallback)successCb
           failure:(FailureRequestCallback)failureCb {
  AFHTTPSessionManager *managerInstance = [HttpClient instance];
  [HttpClient setRequestHeaders:headers];
  [managerInstance PUT:url
            parameters:body
               success:^(NSURLSessionDataTask *task, id responseObject) {
                 successCb(responseObject);
               }
               failure:^(NSURLSessionDataTask *task, NSError *error) {
                 failureCb(error);
               }];
}

+ (PMKPromise *)putWithUrl:(NSString *)url body:(NSDictionary *)body {
  return [HttpClient putWithUrl:url body:body headers:nil];
}

+ (PMKPromise *)putWithUrl:(NSString *)url
                      body:(NSDictionary *)body
                   headers:(NSDictionary *)headers {
  AFHTTPSessionManager *managerInstance = [HttpClient instance];
  [HttpClient setRequestHeaders:headers];
  
  return [managerInstance PUT:url parameters:body];
}

#pragma mark - DELETE HTTP Request
+ (void)deleteWithUrl:(NSString *)url
               params:(NSDictionary *)params
              success:(SuccessRequestCallback)successCb
              failure:(FailureRequestCallback)failureCb {
  [HttpClient deleteWithUrl:url params:params headers:nil success:successCb failure:failureCb];
}

+ (void)deleteWithUrl:(NSString *)url
               params:(NSDictionary *)params
              headers:(NSDictionary *)headers
              success:(SuccessRequestCallback)successCb
              failure:(FailureRequestCallback)failureCb {
  AFHTTPSessionManager *managerInstance = [HttpClient instance];
  [HttpClient setRequestHeaders:headers];
  [managerInstance DELETE:url
               parameters:params
                  success:^(NSURLSessionDataTask *task, id responseObject) {
                    successCb(responseObject);
                  }
                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                    failureCb(error);
                  }];
}

+ (PMKPromise *)deleteWithUrl:(NSString *)url params:(NSDictionary *)params {
  return [HttpClient deleteWithUrl:url params:params headers:nil];
}

+ (PMKPromise *)deleteWithUrl:(NSString *)url
                       params:(NSDictionary *)params
                      headers:(NSDictionary *)headers {
  AFHTTPSessionManager *managerInstance = [HttpClient instance];
  [HttpClient setRequestHeaders:headers];
  
  return [managerInstance DELETE:url parameters:params];
}

+ (FailurePromiseCallback)defaultFailure {
  return ^(NSError *error) {
    NSLog(@"Error: %@", [error localizedDescription]);
  };
}

@end
