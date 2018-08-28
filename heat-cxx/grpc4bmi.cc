#include <bmi_cpp_base.h>
#include <bmi_grpc_server.h>
#include <heat/bmi_heat.hxx>
#include <grpcpp/grpcpp.h>

class BmiHeatCpp: public BmiCppBase {
    protected:
      BmiHeat model;
    public:
      explicit BmiHeatCpp() {
          // actual bmi heat model is constructed during Initialize
      }
      void Initialize(std::string config_file) {
          model.Initialize(config_file);
      }
};

int main(int argc, char const *argv[])
{
    BmiHeatCpp bmimodel;
    std::string server_address = "0.0.0.0:50051";

    BmiGRPCService service(&bmimodel);
    grpc::ServerBuilder builder;
    builder.AddListeningPort(server_address, grpc::InsecureServerCredentials());
    builder.RegisterService(&service);
    std::unique_ptr<grpc::Server> server(builder.BuildAndStart());
    std::cout << "Server listening on " << server_address << std::endl;
    server->Wait();
    return 0;
}
