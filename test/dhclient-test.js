let chai = require('chai');
let chaiHttp = require('chai-http');
let server = require('../dhclient');

let should = chai.should();

chai.use(chaiHttp);


describe('/GET clients', () => {
    it('it should GET all the clients', (done) => {
        chai.request(server)
            .get('/clients')
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.have.property('RC').and.equal(0);
                res.body.should.have.property('items').and.should.be.a('array');
                //res.body.should.be.a('array');
                res.body.length.should.not.be.eql(0);
                done();
            });
    });
});