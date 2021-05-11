//
//  SpiderPage.swift
//  SpiderCoolpc
//
//  Created by Angus Yi on 2021/4/25.
//

import SwiftUI

struct SpiderPage: View {
    
    @ObservedObject var gpuDataHandler = GPUDataHandler()
    
    var body: some View {
        Button("Refresh", action: {
            gpuDataHandler.getCoolpcGPUDatas()
        }).onAppear {
            gpuDataHandler.getCoolpcGPUDatas()
        }
        
        List {
            let headerGpuInfo = GPUInfo(model: "型號", brand: "廠牌", MHz: "MHz", length: "長度", warranty: "保固", price: "價錢")
            Section(header: GPUListCell(gpu: headerGpuInfo)) {
                ForEach(gpuDataHandler.gpuInfoAry) { gpu in
                    GPUListCell(gpu: gpu)
//                        .frame(height: 20, alignment: .center)
                }
            }
        }.environment(\.defaultMinListRowHeight, 20)
    }
}

#if DEBUG
struct SpiderPage_Previews: PreviewProvider {
    static var previews: some View {
        SpiderPage()
    }
}
#endif

struct GPUListCell: View {
    let gpu: GPUInfo
    var body: some View {
        HStack {
            Group {
                Text(gpu.brand ?? "")
                    .foregroundColor(gpu.available ?? true ? .green : .red)
                Divider()
            }
            Group {
                Text(gpu.model ?? "")
                    .foregroundColor(gpu.available ?? true ? .green : .red)
                Divider()
            }
            Group {
                Text(gpu.MHz ?? "")
                    .foregroundColor(gpu.available ?? true ? .green : .red)
                Divider()
            }
            Group {
                Text(gpu.length ?? "")
                    .foregroundColor(gpu.available ?? true ? .green : .red)
                Divider()
            }
            Group {
                Text(gpu.warranty ?? "")
                    .foregroundColor(gpu.available ?? true ? .green : .red)
                Divider()
            }
            Group {
                Text(gpu.price ?? "")
                    .foregroundColor(gpu.available ?? true ? .green : .red)
                Divider()
            }
        }
    }
}
