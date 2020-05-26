import RxCocoa
import RxSwift
import Kingfisher

extension Reactive where Base: ImageCache {
    public func retrieveCacheSize() -> Observable<Int> {
        return Single.create { single in
            self.base.calculateDiskStorageSize { result in
                do {
                    single(.success(Int(try result.get())))
                } catch {
                    single(.error(error))
                }
            }
            return Disposables.create {}
        }.asObservable()
    }

    public func clearCache() -> Observable<Void> {
        return Single.create { single in
            self.base.clearMemoryCache()
            self.base.clearDiskCache(completion: {
                single(.success(()))
            })
            return Disposables.create {}
        }.asObservable()
    }
}

extension ImageCache: ReactiveCompatible {}
