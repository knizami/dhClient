let chai = require('chai');
let chaiHttp = require('chai-http');
var server = require('../dhclient');

let should = chai.should();

chai.use(chaiHttp);

describe('/GET clients', () => {
    it('it should GET all the clients', (done) => {
        chai.request(server)
            .get('/clients')
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.have.property('RC').and.equal(0);
                res.body.should.have.property('items').that.is.an('array');
                res.header.should.have.property('content-length').above(0);
                done();
            });
    });
});