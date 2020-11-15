
import Foundation

class VenturesInteractor {
    
    //MARK: Database Related Updation
    
    private func addVenturesDataToDB(_ data: RealEstateData) -> Bool {
    return APP_DELEGATE.dataStore.write(data)
    }
    private func getVenturesFromDB() -> RealEstateData?
    {
    guard let data = APP_DELEGATE.dataStore.objects(RealEstateData.self), let first = data.first  else {
            return nil
        }
    return first
    }
    private func addDatatoDB(_ model: RealEstateData) -> RealEstateData?
    {
    restoreDb()
    let _ = APP_DELEGATE.dataStore.write(model)
    return getVenturesFromDB()
    }
    
    //MARK: Database Flsuhing when datechange
    
    private func restoreDb()
    {
        let _ = APP_DELEGATE.dataStore.delete(RealEstateData.self)
    let _ = APP_DELEGATE.dataStore.delete(VentureOption.self)
    let _ = APP_DELEGATE.dataStore.delete(Exclusion.self)
    let _ = APP_DELEGATE.dataStore.delete(Venture.self)
    let _ = APP_DELEGATE.dataStore.delete(DoubleExclusions.self)
    }
    
    //MARK: Data fetching from API
    
    private func getVenturesFromApi(completion: @escaping (Result<RealEstateData, ApiError>) -> Void)
    {
        guard let url = URL(string: APIEndPoints.venturesApi) else {completion(.failure(.InvalidUrl))
         return}
         APIService.getDataFromEndpoint(urlString: url) {(error, APIdata) in
        
         if let _ = error {completion(.failure(.Offline))}
         if let galleryData = APIdata{
         JsonParser.getJsonDataObjectfromResponse(withData: galleryData, type: RealEstateData.self) { jsonerr, object in
            if let _ = jsonerr {completion(.failure(.DataMismatch))}
            if let obj = object
            {
            completion(.success(obj))
            }}}}
    }
}


extension VenturesInteractor: VenturesUseCase
{
    func getVenturesData(completion: @escaping(Result<RealEstatePartuculars, ApiError>) -> Void)
    {
    var datechanged : Bool = false
    if let dc = UserDefaults.standard.object(forKey: DefaultConstants.datechange) as? Bool{
    datechanged = dc
    }
    if datechanged
    {
    self.getVenturesFromApi { [weak self] result in
    switch result
    {
    case .success(let model):
    guard let srtSlf = self else {return}
    if let mod = srtSlf.addDatatoDB(model) {
    completion(.success(mod))
    }
    else{
    completion(.failure(.DataSavingFailed))
    }
    completion(.success(model))
    case .failure(let err):
    completion(.failure(err))
    }}}
    else
    {
    if let dat = getVenturesFromDB()
    {
    completion(.success(dat))
    }}}
}
