# CryptoCrazy-VIPER

Bu Swift projesi, VIPER mimarisi kullanılarak kripto para birimlerini listeleyen ve kullanıcıların bu para birimlerinin detaylarını görüntüleyebileceği bir iOS uygulaması oluşturuyor. Aşağıda projede kullanılan her bir bileşenin detayları ve işlevleri açıklanmıştır.

## Özellikler:

### 1. Veri Yapıları:
   - **Crypto**: Kripto para birimlerinin bilgilerini tutan bir veri yapısıdır. `currency` ve `price` adında iki alan içerir. `Decodable` protokolüne uygundur.

### 2. View (Görünüm):
   - **CryptoViewController**: Kripto para birimlerini listelemek için kullanılan ana görünüm sınıfıdır. `UITableViewDelegate` ve `UITableViewDataSource` protokollerini uygular. Kullanıcı, bir kripto para birimini seçtiğinde detayları göstermek üzere `DetailViewController`'a geçiş yapar.
   - **DetailViewController**: Kullanıcının seçtiği kripto para biriminin detaylarını gösteren sınıftır. Bu sınıf, iki `UILabel` kullanarak seçilen kripto para biriminin adını ve fiyatını görüntüler.
   - **AnyView**: `CryptoViewController` ve `DetailViewController` sınıflarının temelini oluşturan bir protokoldür. Görünüm bileşenlerinin, presenter'dan aldığı verilerle güncellenmesini sağlar.

### 3. Presenter:
   - **CryptoPresenter**: Verileri işlemekten ve görünümü güncellemekten sorumlu sınıftır. `Interactor` tarafından sağlanan verileri işler ve sonuçları `View`'a iletir. `AnyPresenter` protokolüne uygundur.
   - **AnyPresenter**: Presenter sınıfının temelini oluşturan protokoldür. `Router`, `Interactor` ve `View` bileşenleri ile iletişim kurar.

### 4. Interactor:
   - **CryptoInteractor**: Kripto para verilerini indirir ve `Presenter` sınıfına iletir. JSON verisini indirir, işler ve sonucu bir `Result` türünde geri döner. `AnyInteractor` protokolüne uygundur.
   - **AnyInteractor**: Interactor sınıfının temelini oluşturan protokoldür. `Presenter` ile iletişim kurarak veri işleme süreçlerini yönetir.

### 5. Router:
   - **CryptoRouter**: VIPER modüllerini başlatan ve gerekli geçişleri yöneten sınıftır. Uygulamanın başlangıç noktası olarak tanımlanır ve modüller arasındaki geçişleri yönetir.
   - **AnyRouter**: Router sınıfının temelini oluşturan protokoldür. Uygulamanın giriş noktası olarak tanımlanır.

### 6. Uzantılar:
   - **UIColor+Hex**: Hex renk kodlarını `UIColor` nesnelerine dönüştürmek için kullanılan bir uzantıdır. Bu uzantı, `UIColor` sınıfına yeni bir `init(hex:)` metodu ekler, bu sayede renkler hex kodlarıyla kolayca tanımlanabilir.

## Proje Yapısı ve Bileşenlerin İşlevleri:

### 1. **CryptoViewController**
   - **Delegate ve DataSource**: `CryptoViewController`, `UITableViewDelegate` ve `UITableViewDataSource` protokollerini uygular ve bu sayede tablo görünümünü yönetir.
   - **Gradyan Arka Plan**: Görünümün arka planı, `CAGradientLayer` kullanılarak dinamik bir gradyan ile doldurulur.
   - **Tablo Hücreleri**: Kripto para birimlerinin isimleri ve fiyatları, her bir tablo hücresinde gösterilir. Her hücreye ayrıca bir gradyan arka plan uygulanır.
   - **Geçiş**: Kullanıcı bir kripto para birimini seçtiğinde, ilgili detaylar `DetailViewController`'a aktarılır ve kullanıcıya gösterilir.

### 2. **DetailViewController**
   - **Seçilen Kripto Para**: Bu sınıf, seçilen kripto para biriminin adını ve fiyatını gösterir. `UILabel` kullanılarak bu bilgiler ekranda ortalanmış şekilde sunulur.
   - **Gradyan Arka Plan**: Detay ekranında da gradyan bir arka plan kullanılır.

### 3. **CryptoPresenter**
   - **Veri İşleme**: `CryptoPresenter`, verilerin işlenmesinden sorumludur. `Interactor` tarafından sağlanan verileri işler ve sonuçları `View` bileşenine iletir.
   - **Hata Yönetimi**: Veri işleme sırasında oluşabilecek hatalar, kullanıcıya uygun bir mesaj ile bildirilir.

### 4. **CryptoInteractor**
   - **Veri İndirme**: `CryptoInteractor`, kripto para verilerini indirir ve bu verileri JSON formatında işler. İndirme ve işleme sonucunu `Presenter`'a iletir.
   - **Hata Yönetimi**: Veri indirimi veya JSON işleme sırasında oluşabilecek hatalar, `Presenter` aracılığıyla yönlendirilir.

### 5. **CryptoRouter**
   - **Modül Başlatma**: `CryptoRouter`, VIPER modüllerinin başlatılmasından ve gerekli geçişlerin yönetilmesinden sorumludur. Bu sınıf, modüller arasındaki iletişimi yönetir.

### 6. **UIColor+Hex Uzantısı**
   - **Hex Kodları ile Renk Tanımlama**: Bu uzantı, hex renk kodlarını `UIColor` nesnelerine dönüştürmek için kullanılır. Kullanıcıların kolayca renk tanımlaması için `init(hex:)` fonksiyonunu ekler.

---
