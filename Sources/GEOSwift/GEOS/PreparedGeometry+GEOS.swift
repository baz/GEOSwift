import geos

public extension PreparedGeometry {
    func contains(_ geometry: GeometryConvertible) throws -> Bool {
        let geosObject = try geometry.geometry.geosObject(with: context)
        // returns 1 on true, 0 on false, 2 on exception
        let result = GEOSPreparedContains_r(context.handle, pointer, geosObject.pointer)
        guard result != 2 else {
            throw GEOSError.libraryError(errorMessages: context.errors)
        }
        return result == 1
    }

    func containsProperly(_ geometry: GeometryConvertible) throws -> Bool {
        let geosObject = try geometry.geometry.geosObject(with: context)
        // returns 1 on true, 0 on false, 2 on exception
        let result = GEOSPreparedContainsProperly_r(context.handle, pointer, geosObject.pointer)
        guard result != 2 else {
            throw GEOSError.libraryError(errorMessages: context.errors)
        }
        return result == 1
    }

    func distance(to geometry: GeometryConvertible) throws -> Double {
        let otherGeosObject = try geometry.geometry.geosObject(with: context)
        var dist: Double = 0
        // returns 0 on exception
        guard GEOSPreparedDistance_r(context.handle, pointer, otherGeosObject.pointer, &dist) != 0 else {
            throw GEOSError.libraryError(errorMessages: context.errors)
        }
        return dist
    }

    func distance(to geometry: GeometryConvertible, within: Double) throws -> Bool {
        let otherGeosObject = try geometry.geometry.geosObject(with: context)
        // returns 1 on true, 0 on false, 2 on exception
        let result = GEOSPreparedDistanceWithin_r(context.handle, pointer, otherGeosObject.pointer, within)
        guard result != 2 else {
            throw GEOSError.libraryError(errorMessages: context.errors)
        }
        return result == 1
    }
}
