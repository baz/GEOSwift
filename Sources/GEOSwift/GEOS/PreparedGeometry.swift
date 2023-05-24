import geos

/// A prepared geometry. Unlike most of GEOSwift, this type is not thread safe.
public final class PreparedGeometry {
    let context: GEOSContext
    private let base: GEOSObject
    let pointer: OpaquePointer

    init(context: GEOSContext, base: GEOSObject) throws {
        self.context = context
        self.base = base
        guard let pointer = GEOSPrepare_r(context.handle, base.pointer) else {
            throw GEOSError.libraryError(errorMessages: context.errors)
        }
        self.pointer = pointer
    }

    deinit {
        GEOSPreparedGeom_destroy_r(context.handle, pointer)
    }
}
