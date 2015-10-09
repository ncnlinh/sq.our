function GetReferenceNumber(ref) {
    if (ref != null) {
        var regex = /([^\/]+)$/g;
        return regex.exec(ref.toString());
    }
}

module.exports.GetReferenceNumber = GetReferenceNumber;