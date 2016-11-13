import Flock

class Production: Configuration {
    func configure() {
        // using vagrant private network ip
        Servers.add(ip: "192.168.33.10", user: "vagrant", roles: [.app, .db, .web])
    }
}
