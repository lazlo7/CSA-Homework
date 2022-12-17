#include <mpi.h>
#include <cstdio>
#include <unistd.h>

constexpr int buffer_len = 1024;
constexpr int sleep_delay_s = 3;
constexpr int process_count = 10;

int main(int argc, char **argv) {
    int i, rank, size;
    char buffer[buffer_len];

    MPI_Status status;
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    
    // Writing message to buffer.
    sprintf(buffer, "Hello from process %d!", rank);

    // Sending message.
    const auto destination = (rank + 1) % process_count;
    const auto before_sending = MPI_Wtime();
    MPI_Send(buffer, buffer_len, MPI_CHAR, destination, rank, MPI_COMM_WORLD);
    printf("[Process %d] Sent message \"%s\" to process %d\n", rank, buffer, destination);

    // Sleeping.
    sleep(sleep_delay_s);    
    
    // Receiving message.
    const auto source = (rank - 1 + process_count) % process_count;
    MPI_Recv(buffer, buffer_len, MPI_CHAR, source, source, MPI_COMM_WORLD, &status);
    const auto after_receiving = MPI_Wtime();
    printf("[Process %d] Received message \"%s\" from process %d\n", rank, buffer, source);
    printf("[Process %d] Sending-receiving took %fs\n", rank, (after_receiving - before_sending));

    MPI_Finalize();
    return 0;
}
